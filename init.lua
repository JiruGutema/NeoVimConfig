-----------------------------------------------------------
-- Set Leader Key
-----------------------------------------------------------
vim.g.mapleader = " "      -- Space as leader
vim.g.maplocalleader = " " -- Local leader

-----------------------------------------------------------
-- Bootstrap Lazy.nvim
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

-----------------------------------------------------------
-- Plugins
-----------------------------------------------------------
require("lazy").setup({

  -- Theme
  { "Mofiqul/vscode.nvim" },

  -- File Explorer + Icons
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },

  -- Telescope (Fuzzy Finder)
  { "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = { "nvim-lua/plenary.nvim" } },

  -- LSP + Mason
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },

  -- Autocomplete
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },

  -- Statusline
  { "nvim-lualine/lualine.nvim" },

  -- Git signs
  { "lewis6991/gitsigns.nvim" },

  -- Autopairs
  { "windwp/nvim-autopairs", config = function()
      require("nvim-autopairs").setup{
          check_ts = true,
          disable_filetype = { "TelescopePrompt", "vim" },
          fast_wrap = { 
              map = "<M-e>",
              chars = { "{", "[", "(", '"', "'" },
              pattern = [=[[%'%"%)%>%]%)%}%,]]=],
              offset = 0,
              end_key = "$",
              keys = "qwertyuiopzxcvbnmasdfghjkl",
              check_comma = true,
              highlight = "Search",
              highlight_grey = "Comment"
          },
      }
  end},

  -- Smooth scrolling
  { "karb94/neoscroll.nvim", event = "WinScrolled", config = function()
      require('neoscroll').setup({
        easing_function = "cubic",
        hide_cursor = true,
      })
  end},

})

-----------------------------------------------------------
-- Appearance
-----------------------------------------------------------
vim.cmd("colorscheme vscode")

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------
-- jj to escape
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('t', 'jj', '<C-\\><C-n>', { noremap = true, silent = true })

-- Telescope
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>", { noremap = true, silent = true })

-- Smooth half-page scroll with recenter
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Toggle Nvim-Tree (leader + n)
vim.keymap.set("n", "<leader>n", function()
    require("nvim-tree.api").tree.toggle({ find_file = true })
end, { noremap = true, silent = true })

-- Format file using LSP
vim.keymap.set("n", "<C-S-i>", function()
    vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true })

-----------------------------------------------------------
-- Nvim-Tree
-----------------------------------------------------------
require("nvim-tree").setup({
  update_focused_file = {
    enable = true,
    update_cwd = true,
  },
  view = { width = 30, side = "left" },
})

-----------------------------------------------------------
-- Mason LSP Installer
-----------------------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "tsserver",   -- TypeScript / JavaScript / React / Next
    "html",
    "cssls",
    "jsonls",
    "lua_ls",
    "pyright",
    "gopls",
    "omnisharp",  -- C#
    "jdtls",      -- Java
  }
})

-----------------------------------------------------------
-- LSP + Autocomplete
-----------------------------------------------------------
local lspconfig = require("lspconfig")
local capabilities = require("cmp_nvim_lsp").default_capabilities()

-- tsserver for React/Next
lspconfig.tsserver.setup{
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
  root_dir = lspconfig.util.root_pattern("package.json", "tsconfig.json", ".git")
}

-- Other LSPs
lspconfig.html.setup({ capabilities = capabilities })
lspconfig.cssls.setup({ capabilities = capabilities })
lspconfig.jsonls.setup({ capabilities = capabilities })
lspconfig.lua_ls.setup({ capabilities = capabilities })
lspconfig.pyright.setup({ capabilities = capabilities })
lspconfig.gopls.setup({ capabilities = capabilities })
lspconfig.omnisharp.setup({ capabilities = capabilities })
lspconfig.jdtls.setup({ capabilities = capabilities })

-----------------------------------------------------------
-- nvim-cmp Autocomplete
-----------------------------------------------------------
local cmp = require("cmp")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"] = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

-----------------------------------------------------------
-- Lualine Statusline
-----------------------------------------------------------
require("lualine").setup({
  options = { theme = "vscode" }
})

-----------------------------------------------------------
-- Git Signs
-----------------------------------------------------------
require("gitsigns").setup()

-----------------------------------------------------------
-- Format on Save
-----------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = {"*.py", "*.ts", "*.js", "*.jsx", "*.go", "*.lua", "*.cs", "*.java"},
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
