-- Module definition ==========================================================
local bettertf = {}
local M = {}

-- Module setup
function bettertf.setup(config)
    -- Export module
    _G.bettertf = bettertf

    -- Setup config
    config = M.setup_config(config)

    -- Apply config
    M.apply_config(config)

    -- Highlight groups
    vim.api.nvim_set_hl(0, 'bettertf', { link = 'Search' })

    -- Module behavior
    vim.api.nvim_create_augroup('bettertf', {})

    vim.api.nvim_create_autocmd('CursorMoved', {
        group = 'bettertf',
        callback = function()
            return bettertf.on_cursormoved()
        end,
    })

    vim.api.nvim_create_autocmd({ 'BufLeave', 'InsertEnter' }, {
        group = 'bettertf',
        callback = function()
            return bettertf.stop_jumping()
        end,
    })
end

-- Module config
bettertf.config = {
    mappings = {
        forward = 'f',
        backward = 'F',
        forward_till = 't',
        backward_till = 'T',
        repeat_jump = ';',
    },

    -- Delay values
    delay = {
        highlight = 800, -- Delay between jump and highlighting all possible jumps
        idle_stop = 3000, -- Delay between jump and automatic stop if idle (no jump is done)
    },
}

-- Module data ================================================================
--- Data about jumping state
---
--- It stores various information used in this module. All elements, except
--- `jumping`, is about the latest jump. They are used as default values for
--- similar arguments.
bettertf.state = {
    target = nil,
    backward = false,
    till = false,
    n_times = 1,
    mode = nil,
    jumping = false,
}

-- Module functionality =======================================================
--- Jump to target
---
--- Takes a string and jumps to its first occurrence in desired direction.
---
--- All default values are taken from |bettertf.state| to emulate latest jump.
function bettertf.jump(target, backward, till, n_times)
    if M.is_disabled() then
        return
    end

    -- Cache inputs for future use
    M.update_state(target, backward, till, n_times)

    if bettertf.state.target == nil then
        M.notify('Can not jump because there is no recent `target`.')
        return
    end

    -- Determine if target is present anywhere in order to correctly enter
    -- jumping mode. If not, jumping mode is not possible.
    local escaped_target = vim.fn.escape(bettertf.state.target, [[\]])
    local search_pattern = ([[\V%s]]):format(escaped_target)
    local target_is_present = vim.fn.search(search_pattern, 'wn') ~= 0
    if not target_is_present then
        return
    end

    -- Construct search and highlight patterns
    local flags = bettertf.state.backward and 'Wb' or 'W'
    local pattern, hl_pattern = [[\V%s]], [[\V%s]]
    if bettertf.state.till then
        if bettertf.state.backward then
            pattern, hl_pattern = [[\V\(%s\)\@<=\.]], [[\V%s\.\@=]]
            flags = ('%se'):format(flags)
        else
            pattern, hl_pattern = [[\V\.\(%s\)\@=]], [[\V\.\@<=%s]]
        end
    end

    pattern, hl_pattern = pattern:format(escaped_target), hl_pattern:format(escaped_target)

    -- Delay highlighting after stopping previous one
    M.timers.highlight:stop()
    M.timers.highlight:start(
        -- Update highlighting immediately if any highlighting is already present
        M.is_highlighting() and 0 or bettertf.config.delay.highlight,
        0,
        vim.schedule_wrap(function()
            M.highlight(hl_pattern)
        end)
    )

    -- Start idle timer after stopping previous one
    M.timers.idle_stop:stop()
    M.timers.idle_stop:start(
        bettertf.config.delay.idle_stop,
        0,
        vim.schedule_wrap(function()
            bettertf.stop_jumping()
        end)
    )

    -- Make jump(s)
    M.n_cursor_moved = 0
    bettertf.state.jumping = true
    for _ = 1, bettertf.state.n_times do
        vim.fn.search(pattern, flags)
    end

    -- Open enough folds to show jump
    vim.cmd('normal! zv')
end

--- Make smart jump
---
--- If the last movement was a jump, perform another jump with the same target.
--- Otherwise, wait for a target input (via |getchar()|). Respects |v:count|.
---
--- All default values are taken from |bettertf.state| to emulate latest jump.
function bettertf.smart_jump(backward, till)
    if M.is_disabled() then
        return
    end

    -- Jumping should stop after mode change. Use `mode(1)` to track 'omap' case.
    local cur_mode = vim.fn.mode(1)
    if bettertf.state.mode ~= cur_mode then
        bettertf.stop_jumping()
    end

    -- Ask for target only when needed
    local target
    if not bettertf.state.jumping or bettertf.state.target == nil then
        target = M.get_target()
        -- Stop if user supplied invalid target
        if target == nil then
            return
        end
    end

    M.update_state(target, backward, till, vim.v.count1)

    bettertf.jump()
end

--- Make expression jump
---
--- Cache information about the jump and return string with command to perform
--- jump. Designed to be used inside Operator-pending mapping (see
--- |omap-info|). Always asks for target (via |getchar()|). Respects |v:count|.
---
--- All default values are taken from |bettertf.state| to emulate latest jump.
function bettertf.expr_jump(backward, till)
    if M.is_disabled() then
        return ''
    end

    -- Always ask for `target` as this will be used only in operator-pending
    -- mode. Dot-repeat will be implemented via expression-mapping.
    local target = M.get_target()
    -- Stop if user supplied invalid target
    if target == nil then
        return
    end
    M.update_state(target, backward, till, vim.v.count1)

    return vim.api.nvim_replace_termcodes('v:<C-u>lua bettertf.jump()<CR>', true, true, true)
end

--- Stop jumping
---
--- Removes highlights (if any) and forces the next smart jump to prompt for
--- the target. Automatically called on appropriate Neovim |events|.
function bettertf.stop_jumping()
    M.timers.highlight:stop()
    M.timers.idle_stop:stop()
    bettertf.state.jumping = false
    M.unhighlight()
end

--- Act on |CursorMoved|
function bettertf.on_cursormoved()
    -- Check if jumping to avoid unnecessary actions on every CursorMoved
    if bettertf.state.jumping then
        M.n_cursor_moved = M.n_cursor_moved + 1
        -- Stop jumping only if `CursorMoved` was not a result of smart jump
        if M.n_cursor_moved > 1 then
            bettertf.stop_jumping()
        end
    end
end

-- Helper data ================================================================
-- Module default config
M.default_config = bettertf.config

-- Counter of number of CursorMoved events
M.n_cursor_moved = 0

-- Timers for different delay-related functionalities
M.timers = { highlight = vim.loop.new_timer(), idle_stop = vim.loop.new_timer() }

-- Information about last match highlighting (stored *per window*):
-- - Key: windows' unique buffer identifiers.
-- - Value: table with:
--     - `id` field for match id (from `vim.fn.matchadd()`).
--     - `pattern` field for highlighted pattern.
M.window_matches = {}

-- Helper functionality =======================================================
-- Settings -------------------------------------------------------------------
function M.setup_config(config)
    -- General idea: if some table elements are not present in user-supplied
    -- `config`, take them from default config
    vim.validate { config = { config, 'table', true } }
    config = vim.tbl_deep_extend('force', M.default_config, config or {})

    -- Soft deprecate `config.highlight_delay`
    if config.highlight_delay then
        M.notify('`highlight_delay` is now deprecated. Please use `delay.highlight` instead.')
        config.delay.highlight = config.highlight_delay
    end

    -- Validate per nesting level to produce correct error message
    vim.validate {
        mappings = { config.mappings, 'table' },
        delay = { config.delay, 'table' },
    }

    vim.validate {
        ['delay.highlight'] = { config.delay.highlight, 'number' },
        ['delay.idle_stop'] = { config.delay.idle_stop, 'number' },

        ['mappings.forward'] = { config.mappings.forward, 'string' },
        ['mappings.backward'] = { config.mappings.backward, 'string' },
        ['mappings.forward_till'] = { config.mappings.forward_till, 'string' },
        ['mappings.backward_till'] = { config.mappings.backward_till, 'string' },
        ['mappings.repeat_jump'] = { config.mappings.repeat_jump, 'string' },
    }

    return config
end

function M.apply_config(config)
    bettertf.config = config

    M.map('n', config.mappings.forward, [[<Cmd>lua bettertf.smart_jump(false, false)<CR>]])
    M.map('n', config.mappings.backward, [[<Cmd>lua bettertf.smart_jump(true, false)<CR>]])
    M.map('n', config.mappings.forward_till, [[<Cmd>lua bettertf.smart_jump(false, true)<CR>]])
    M.map('n', config.mappings.backward_till, [[<Cmd>lua bettertf.smart_jump(true, true)<CR>]])
    M.map('n', config.mappings.repeat_jump, [[<Cmd>lua bettertf.jump()<CR>]])

    M.map('x', config.mappings.forward, [[<Cmd>lua bettertf.smart_jump(false, false)<CR>]])
    M.map('x', config.mappings.backward, [[<Cmd>lua bettertf.smart_jump(true, false)<CR>]])
    M.map('x', config.mappings.forward_till, [[<Cmd>lua bettertf.smart_jump(false, true)<CR>]])
    M.map('x', config.mappings.backward_till, [[<Cmd>lua bettertf.smart_jump(true, true)<CR>]])
    M.map('x', config.mappings.repeat_jump, [[<Cmd>lua bettertf.jump()<CR>]])

    M.map('o', config.mappings.forward, [[v:lua.bettertf.expr_jump(v:false, v:false)]], { expr = true })
    M.map('o', config.mappings.backward, [[v:lua.bettertf.expr_jump(v:true, v:false)]], { expr = true })
    M.map('o', config.mappings.forward_till, [[v:lua.bettertf.expr_jump(v:false, v:true)]], { expr = true })
    M.map('o', config.mappings.backward_till, [[v:lua.bettertf.expr_jump(v:true, v:true)]], { expr = true })
    M.map('o', config.mappings.repeat_jump, [[v:lua.bettertf.expr_jump()]], { expr = true })
end

function M.is_disabled()
    return vim.g.minijump_disable == true or vim.b.minijump_disable == true
end

-- Highlighting ---------------------------------------------------------------
function M.highlight(pattern)
    -- Don't do anything if already highlighting input pattern
    if M.is_highlighting(pattern) then
        return
    end

    -- Stop highlighting possible previous pattern. Needed to adjust highlighting
    -- when inside jumping but a different kind one. Example: first jump with
    -- `till = false` and then, without jumping stop, jump to same character with
    -- `till = true`. If this character is first on line, highlighting should change
    M.unhighlight()

    local match_id = vim.fn.matchadd('bettertf', pattern)
    M.window_matches[vim.api.nvim_get_current_win()] = { id = match_id, pattern = pattern }
end

function M.unhighlight()
    -- Remove highlighting from all windows as jumping is intended to work only
    -- in current window. This will work also from other (usually popup) window.
    for win_id, match_info in pairs(M.window_matches) do
        if vim.api.nvim_win_is_valid(win_id) then
            -- Use `pcall` because there is an error if match id is not present. It
            -- can happen if something else called `clearmatches`.
            pcall(vim.fn.matchdelete, match_info.id, win_id)
            M.window_matches[win_id] = nil
        end
    end
end

---@param pattern string Highlight pattern to check for. If `nil`, checks for
---   any highlighting registered in current window.
---@private
function M.is_highlighting(pattern)
    local win_id = vim.api.nvim_get_current_win()
    local match_info = M.window_matches[win_id]
    if match_info == nil then
        return false
    end
    return pattern == nil or match_info.pattern == pattern
end

-- Utilities ------------------------------------------------------------------
function M.notify(msg)
    vim.notify(('(mini.jump) %s'):format(msg))
end

function M.update_state(target, backward, till, n_times)
    bettertf.state.mode = vim.fn.mode(1)

    -- Don't use `? and <1> or <2>` because it doesn't work when `<1>` is `false`
    if target ~= nil then
        bettertf.state.target = target
    end
    if backward ~= nil then
        bettertf.state.backward = backward
    end
    if till ~= nil then
        bettertf.state.till = till
    end
    if n_times ~= nil then
        bettertf.state.n_times = n_times
    end
end

function M.get_target()
    local needs_help_msg = true
    vim.defer_fn(function()
        if not needs_help_msg then
            return
        end
        M.notify('Enter target single character ')
    end, 1000)
    local ok, char = pcall(vim.fn.getchar)
    needs_help_msg = false

    -- Terminate if couldn't get input (like with <C-c>) or it is `<Esc>`
    if not ok or char == 27 then
        return
    end

    if type(char) == 'number' then
        char = vim.fn.nr2char(char)
    end
    return char
end

function M.map(mode, key, rhs, opts)
    if key == '' then
        return
    end

    opts = vim.tbl_deep_extend('force', { noremap = true }, opts or {})
    vim.api.nvim_set_keymap(mode, key, rhs, opts)
end

bettertf.setup()

return bettertf
