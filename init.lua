-----------------------------------------------------------
-- Set Leader Key
-----------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "

-----------------------------------------------------------
-- Bootstrap Lazy.nvim
-----------------------------------------------------------
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none",
    "https://github.com/folke/lazy.nvim.git",
    "--branch=stable",
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

  -- Telescope
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
  { "windwp/nvim-autopairs" },

  -- Smooth scrolling
  { "karb94/neoscroll.nvim", event = "WinScrolled" },
})

-----------------------------------------------------------
-- Appearance
-----------------------------------------------------------
vim.cmd("colorscheme vscode")

-----------------------------------------------------------
-- General Settings
-----------------------------------------------------------
vim.opt.number = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"
vim.opt.relativenumber = true

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('t', 'jj', '<C-\\><C-n>', { noremap = true, silent = true })

-- Telescope
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>", { noremap = true, silent = true })

-- Smooth half-page scroll + recenter
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Nvim-Tree toggle
vim.keymap.set("n", "<leader>n", function()
    require("nvim-tree.api").tree.toggle({ find_file = true })
end, { noremap = true, silent = true })

-- Format with LSP
vim.keymap.set("n", "<C-S-i>", function()
    vim.lsp.buf.format({ async = true })
end, { noremap = true, silent = true })

-- Enable clipboard support (copy/paste with system clipboard)
vim.opt.clipboard = "unnamedplus"   -- Linux/Wayland/WSL
-----------------------------------------------------------
-- Nvim-Tree
-----------------------------------------------------------
require("nvim-tree").setup({
  update_focused_file = { enable = true, update_cwd = true },
  view = { width = 30, side = "left" },
})
-----------------------------------------------------------
-- Smart C-h / C-l : switch between NvimTree and editor
-----------------------------------------------------------
local function smart_window_nav(key)
  local current_win = vim.api.nvim_get_current_win()
  local tree_win = require("nvim-tree.api").tree.winid()  -- Fixed: renamed from get_tree_winid()

  if tree_win and vim.api.nvim_win_is_valid(tree_win) then
    local is_in_tree = current_win == tree_win
    if is_in_tree and (key == "h" or key == "l") then
      -- We are in NvimTree → go to the previous (code) window
      vim.cmd("wincmd p")
    else
      -- We are not in NvimTree → go to NvimTree
      require("nvim-tree.api").tree.focus()
    end
  else
    -- Fallback: normal window navigation if tree is closed
    vim.cmd("wincmd " .. key)
  end
end

-- Ctrl+h and Ctrl+l in Normal mode
vim.keymap.set("n", "<C-h>", function() smart_window_nav("h") end, { desc = "Focus NvimTree or left window" })
vim.keymap.set("n", "<C-l>", function() smart_window_nav("l") end, { desc = "Focus editor from NvimTree or right window" })

-- Optional: also make it work from Terminal and other buffers
vim.keymap.set("t", "<C-h>", "<C-\\><C-n><C-h>", { desc = "Terminal → left" })
vim.keymap.set("t", "<C-l>", "<C-\\><C-n><C-l>", { desc = "Terminal → right" })
-----------------------------------------------------------
-- Mason
-----------------------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = {
    "ts_ls", "html", "cssls", "jsonls", "lua_ls",
    "pyright", "gopls", "omnisharp", "jdtls"
  },
  automatic_installation = true,
})

-----------------------------------------------------------
-- LSP Configuration (New 2025+ way - no more deprecated require("lspconfig"))
-----------------------------------------------------------
local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("ts_ls", {
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
  root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" }),
})
vim.lsp.config("html",     { capabilities = capabilities })
vim.lsp.config("cssls",    { capabilities = capabilities })
vim.lsp.config("jsonls",   { capabilities = capabilities })

vim.lsp.config("lua_ls", {
  capabilities = capabilities,
  settings = {
    Lua = {
      diagnostics = { globals = { "vim" } },
      workspace = { library = vim.api.nvim_get_runtime_file("", true) },
    },
  },
})

vim.lsp.config("pyright",  { capabilities = capabilities })
vim.lsp.config("gopls",    { capabilities = capabilities })
vim.lsp.config("omnisharp",{
  capabilities = capabilities,
  cmd = { "omnisharp" },
})
vim.lsp.config("jdtls",    { capabilities = capabilities })

-----------------------------------------------------------
-- nvim-cmp
-----------------------------------------------------------
local cmp = require("cmp")
local cmp_autopairs = require('nvim-autopairs.completion.cmp')
cmp.event:on("confirm_done", cmp_autopairs.on_confirm_done())

cmp.setup({
  mapping = {
    ["<Tab>"]   = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
    ["<CR>"]    = cmp.mapping.confirm({ select = true }),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  },
})

-----------------------------------------------------------
-- Autopairs
-----------------------------------------------------------
require("nvim-autopairs").setup({
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
    highlight_grey = "Comment",
  },
})

-----------------------------------------------------------
-- Lualine
-----------------------------------------------------------
require("lualine").setup({
  options = { theme = "vscode" },
})

-----------------------------------------------------------
-- Gitsigns
-----------------------------------------------------------
require("gitsigns").setup()

-----------------------------------------------------------
-- Neoscroll
-----------------------------------------------------------
require("neoscroll").setup({
  easing_function = "cubic",
  hide_cursor = true,
})

-----------------------------------------------------------
-- Format on Save
-----------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.py", "*.ts", "*.tsx", "*.js", "*.jsx", "*.go", "*.lua", "*.cs", "*.java" },
  callback = function()
    vim.lsp.buf.format({ async = false })
  end,
})
