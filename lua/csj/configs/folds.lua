local status_ok, folds = pcall(require, 'pretty-fold')
if not status_ok then
    return
end

folds.setup {
    fill_char = ' ',
    sections = {
        left = {
            'content',
        },
        right = {
            ' ',
            'number_of_folded_lines',
            function(config)
                return config.fill_char:rep(3)
            end,
        },
    },
    remove_fold_markers = true,
    keep_indentation = true, -- Keep the indentation of the content of the fold string.
    -- Possible values:
    -- "delete" : Delete all comment signs from the fold string.
    -- "spaces" : Replace all comment signs with equal number of spaces.
    -- false    : Do nothing with comment signs.
    process_comment_signs = 'spaces',
    -- List of patterns that will be removed from content foldtext section.
    stop_words = {
        '@brief%s*', -- (for cpp) Remove '@brief' and all spaces after.
        ':',
    },
    add_close_pattern = false,
    matchup_patterns = {
        { '{', '}' },
        { '%(', ')' }, -- % to escape lua pattern char
        { '%[', ']' }, -- % to escape lua pattern char
        { 'if%s', 'end' },
        { 'do%s', 'end' },
        { 'for%s', 'end' },
    },
}

local status_preview_ok, folds_preview = pcall(require, 'pretty-fold.preview')
if not status_preview_ok then
    return
end

folds_preview.setup_keybinding('h')
