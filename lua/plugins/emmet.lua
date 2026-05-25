-- return {
--   {
--     "mattn/emmet-vim",
--     ft = {
--       "html",
--       "css",
--       "javascriptreact",
--       "typescriptreact",
--       "vue",
--       "svelte",
--     },
--   },
-- }

return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        emmet_ls = {
          filetypes = {
            "html",
            "css",
            "scss",
            "javascriptreact",
            "typescriptreact",
          },
        },
      },
    },
  },
}
