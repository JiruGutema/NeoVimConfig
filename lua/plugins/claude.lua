return {
  "coder/claudecode.nvim",
  dependencies = { "folke/snacks.nvim" },
  opts = {
    -- Automatically uses the global "claude" binary
    terminal_cmd = "claude",
  },
  config = true,
  keys = {
    { "<leader>ai", ":ClaudeCode<CR>", desc = "Launch Claude Code" },
  },
}
