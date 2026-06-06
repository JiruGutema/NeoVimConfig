return {
	"folke/snacks.nvim",
	opts = {
		picker = {
			sources = {
				explorer = {
					layout = {
						auto_hide = { "input" },
					},
				},
			},
		},
		dashboard = {
			enabled = true,
			preset = {
				keys = {
					{ icon = " ", key = "n", desc = "New File", action = ":ene | startinsert" },
					{ icon = "󰈞 ", key = "f", desc = "Find File", action = ":lua Snacks.dashboard.pick('files')" },
					{ icon = " ", key = "r", desc = "Recent Files", action = ":lua Snacks.dashboard.pick('oldfiles')" },
					{ icon = "󰊄 ", key = "g", desc = "Find Text", action = ":lua Snacks.dashboard.pick('live_grep')" },
					{
						icon = " ",
						key = "c",
						desc = "Config",
						action = ":lua Snacks.dashboard.pick('files', { cwd = vim.fn.stdpath('config') })",
					},
					{ icon = "󰒲 ", key = "L", desc = "Lazy", action = ":Lazy", enabled = package.loaded.lazy ~= nil },
					{ icon = " ", key = "q", desc = "Quit", action = ":qa" },
				},
			},
			sections = {
				-- ASCII header + OS line + live system-info table (from modules.dashboard)
				function()
					return {
						pane = 1,
						padding = 1,
						header = require("modules.dashboard").header,
					}
				end,
				-- Local weather (async; harmless no-op if offline)
				{
					pane = 1,
					section = "terminal",
					cmd = "curl -s -m 2 'https://wttr.in/?0FQ' | sed 's/^/  /' || echo -n",
					height = 6,
					padding = 1,
				},
				{ pane = 1, section = "startup" },
				{ pane = 2, section = "keys", gap = 1, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Recent Files",
					section = "recent_files",
					indent = 2,
					padding = 1,
				},
				{ pane = 2, icon = "󰙅 ", title = "Projects", section = "projects", indent = 2, padding = 1 },
				{
					pane = 2,
					icon = " ",
					title = "Git Status",
					section = "terminal",
					enabled = function()
						return Snacks.git.get_root() ~= nil
					end,
					cmd = "git --no-pager diff --stat -B -M -C && git status --short",
					height = 5,
					padding = 1,
					ttl = 5 * 60,
					indent = 3,
				},
			},
		},
	},
}
