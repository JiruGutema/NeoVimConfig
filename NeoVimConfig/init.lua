-----------------------------------------------------------
-- Set Leader Key & Clipboard
-----------------------------------------------------------
vim.g.mapleader = " "
vim.g.maplocalleader = " "
vim.opt.clipboard = "unnamedplus"   -- System clipboard (Linux/WSL)

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
  { "Mofiqul/vscode.nvim" },
  { "nvim-tree/nvim-tree.lua" },
  { "nvim-tree/nvim-web-devicons" },
  { "nvim-telescope/telescope.nvim", tag = "0.1.5", dependencies = { "nvim-lua/plenary.nvim" } },
  { "neovim/nvim-lspconfig" },
  { "williamboman/mason.nvim" },
  { "williamboman/mason-lspconfig.nvim" },
  { "hrsh7th/nvim-cmp" },
  { "hrsh7th/cmp-nvim-lsp" },
  { "hrsh7th/cmp-buffer" },
  { "hrsh7th/cmp-path" },
  { "nvim-lualine/lualine.nvim" },
  { "lewis6991/gitsigns.nvim" },
  { "windwp/nvim-autopairs" },
  { "karb94/neoscroll.nvim", event = "WinScrolled" },
  { "Pocco81/auto-save.nvim" },

  -- GitHub Copilot (official, fastest, 2025)
  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.g.copilot_no_tab_map = true
      vim.keymap.set("i", "<C-J>", 'copilot#Accept("\\<CR>")', { expr = true, silent = true })
      vim.keymap.set("i", "<C-]>", "<Plug>(copilot-next)",     { silent = true })
      vim.keymap.set("i", "<C-[>", "<Plug>(copilot-previous)", { silent = true })
      vim.keymap.set("i", "<C-\\>", "<Plug>(copilot-dismiss)", { silent = true })
    end,
  },
})

-----------------------------------------------------------
-- Appearance & General Settings
-----------------------------------------------------------
vim.cmd("colorscheme vscode")
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.cursorline = true
vim.opt.signcolumn = "yes"

-----------------------------------------------------------
-- Keymaps
-----------------------------------------------------------
vim.keymap.set('i', 'jj', '<Esc>', { noremap = true, silent = true })
vim.keymap.set('t', 'jj', '<C-\\><C-n>', { noremap = true, silent = true })

-- Telescope
vim.keymap.set("n", "<C-p>", ":Telescope find_files<CR>", { noremap = true, silent = true })
vim.keymap.set("n", "<C-f>", ":Telescope live_grep<CR>", { noremap = true, silent = true })

-- Smooth scrolling
vim.keymap.set("n", "<C-d>", "<C-d>zz", { noremap = true, silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { noremap = true, silent = true })

-- Nvim-Tree toggle
vim.keymap.set("n", "<leader>n", function()
  require("nvim-tree.api").tree.toggle({ find_file = true })
end, { noremap = true, silent = true })

-- Move lines
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { noremap = true, silent = true })
vim.keymap.set("n", "<A-Up>",   ":m .-2<CR>==", { noremap = true, silent = true })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("v", "<A-Up>",   ":m '<-2<CR>gv=gv", { noremap = true, silent = true })
vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { noremap = true, silent = true })
vim.keymap.set("i", "<A-Up>",   "<Esc>:m .-2<CR>==gi", { noremap = true, silent = true })

-- Duplicate lines (VS Code style)
vim.keymap.set("n", "<S-A-Down>", "yyp", { noremap = true, silent = true })
vim.keymap.set("n", "<S-A-Up>",   "yyP", { noremap = true, silent = true })
vim.keymap.set("v", "<S-A-Down>", "ygv'>p", { noremap = true, silent = true })
vim.keymap.set("v", "<S-A-Up>",   "ygv'<P", { noremap = true, silent = true })

-- Format
vim.keymap.set("n", "<C-S-i>", function() vim.lsp.buf.format({ async = true }) end, { noremap = true, silent = true })

-- Smart Ctrl+h / Ctrl+l (explorer ↔ editor)
local function smart_nav(key)
  local cur = vim.api.nvim_get_current_win()
  local tree_win = require("nvim-tree.api").tree.winid()
  if tree_win and vim.api.nvim_win_is_valid(tree_win) then
    if cur == tree_win then
      vim.cmd("wincmd p")           -- in tree → go back to editor
    else
      require("nvim-tree.api").tree.focus()  -- in editor → go to tree
    end
  else
    vim.cmd("wincmd " .. key)       -- fallback
  end
end
vim.keymap.set("n", "<C-h>", function() smart_nav("h") end)
vim.keymap.set("n", "<C-l>", function() smart_nav("l") end)

-----------------------------------------------------------
-- Nvim-Tree
-----------------------------------------------------------
require("nvim-tree").setup({
  update_focused_file = { enable = true, update_cwd = true },
  view = { width = 30, side = "left" },
})

-----------------------------------------------------------
-- Mason & LSP (2025+ way)
-----------------------------------------------------------
require("mason").setup()
require("mason-lspconfig").setup({
  ensure_installed = { "ts_ls", "html", "cssls", "jsonls", "lua_ls", "pyright", "gopls", "omnisharp", "jdtls" },
  automatic_installation = true,
})

local capabilities = require("cmp_nvim_lsp").default_capabilities()

vim.lsp.config("ts_ls", {
  capabilities = capabilities,
  filetypes = { "typescript", "typescriptreact", "typescript.tsx", "javascript", "javascriptreact", "javascript.jsx" },
  root_dir = vim.fs.root(0, { "package.json", "tsconfig.json", ".git" }),
})
vim.lsp.config("html",      { capabilities = capabilities })
vim.lsp.config("cssls",     { capabilities = capabilities })
vim.lsp.config("jsonls",    { capabilities = capabilities })
vim.lsp.config("lua_ls",    { capabilities = capabilities, settings = { Lua = { diagnostics = { globals = { "vim" } }, workspace = { library = vim.api.nvim_get_runtime_file("", true) } } } })
vim.lsp.config("pyright",   { capabilities = capabilities })
vim.lsp.config("gopls",     { capabilities = capabilities })
vim.lsp.config("omnisharp", { capabilities = capabilities, cmd = { "omnisharp" } })
vim.lsp.config("jdtls",     { capabilities = capabilities })

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
-- Autopairs, Lualine, Gitsigns, Neoscroll
-----------------------------------------------------------
require("nvim-autopairs").setup({
  check_ts = true,
  disable_filetype = { "TelescopePrompt", "vim" },
})
require("lualine").setup({ options = { theme = "vscode" } })
require("gitsigns").setup()
require("neoscroll").setup({ easing_function = "cubic", hide_cursor = true })

-----------------------------------------------------------
-- Auto-save
-----------------------------------------------------------
require("auto-save").setup({
  enabled = true,
  execution_message = { message = "Auto-saved", dim = 0.18 },
  trigger_events = { "InsertLeave", "TextChanged" },
  write_all_buffers = false,
})

-----------------------------------------------------------
-- Format on Save
-----------------------------------------------------------
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = { "*.py", "*.ts", "*.tsx", "*.js", "*.jsx", "*.go", "*.lua", "*.cs", "*.java" },
  callback = function() vim.lsp.buf.format({ async = false }) end,
})