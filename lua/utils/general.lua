-- General helpers used by the dashboard module.
-- These mirror the small surface the Necrom4 dotfiles dashboard expects:
--   term_cmd     - run a shell command and return its trimmed stdout
--   system_type  - "darwin" | "wsl" | "linux"
--   in_yadm_env  - yadm (dotfiles manager) shim; no-op for a normal setup
local M = {}

--- Run a shell command and return trimmed stdout ("" on failure).
--- stderr is discarded so a failing probe never pollutes the dashboard.
---@param cmd string
---@return string
function M.term_cmd(cmd)
	local handle = io.popen(cmd .. " 2>/dev/null")
	if not handle then
		return ""
	end
	local result = handle:read("*a") or ""
	handle:close()
	-- strip trailing whitespace/newlines
	return (result:gsub("%s+$", ""))
end

--- Detect the broad platform the dashboard branches on.
---@return "darwin"|"wsl"|"linux"
function M.system_type()
	local uname = vim.loop.os_uname()
	if uname.sysname == "Darwin" then
		return "darwin"
	end
	if (uname.release or ""):lower():find("microsoft") then
		return "wsl"
	end
	return "linux"
end

--- The reference config stores dotfiles with yadm and wraps lookups in this
--- helper. Without yadm we simply run the callback in the current environment
--- and pass through its return value (yadm_repo is left nil for callers).
---@generic T
---@param fn fun(yadm_repo: string?): T
---@return T
function M.in_yadm_env(fn)
	return fn(nil)
end

return M 