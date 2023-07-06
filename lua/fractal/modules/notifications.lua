local M = {
	-- DESCRIPTION: Override the builtin way of notifying changes to the user,
	-- this module overrides vim.notify to use the `notify-send` command instead,
	-- which makes the notifications "integrate" with your DE/WM in a way.
}

local log_level_to_urgency = {
	[1] = "low",
	[2] = "low",
	[3] = "normal",
	[4] = "critical",
}

-- Send notifications through the `notify-send` command line application.
function M.notify_send(msg, log_level, opts)
	log_level = log_level or 3
	opts = opts or {}
	local title = opts.title
	local timeout = opts.timeout
	local urgency = log_level_to_urgency[log_level] or "normal"

	local command = { "notify-send", "-u", urgency, "-i", "nvim", "-a", "Neovim" }

	if timeout then vim.list_extend(command, { "-t", string.format("%d", timeout * 1000) }) end

	if title then
		vim.list_extend(command, { title, msg })
	else
		vim.list_extend(command, { msg })
	end

	vim.fn.system(command)
end

function M.setup() vim.notify = M.notify_send end

return M
