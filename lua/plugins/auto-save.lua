return {
  "Pocco81/auto-save.nvim",
  config = function()
    require("auto-save").setup({
      enabled = true,
      trigger_events = { "InsertLeave", "TextChanged" },
      write_all_buffers = false,
    })
  end,
}
