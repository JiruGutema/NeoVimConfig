
return {
  "folke/snacks.nvim",
  opts = {
    picker = {
      layout = {
        preset = "ivy",
        hidden = { "preview", "input" },
      },
    },
    explorer = {
      -- If you only want to hide in explorer:
      layout = {
        hidden = { "preview", "input" },
      },
    },
  },
}
