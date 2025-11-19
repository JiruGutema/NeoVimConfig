-- Exit insert/terminal quickly
vim.keymap.set("i", "jj", "<Esc>", { desc = "Exit insert mode" })
vim.keymap.set("t", "jj", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- Move lines (replace Alt with leader if Alt unreliable)
vim.keymap.set("n", "<A-Up>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("n", "<A-Down>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("v", "<A-Up>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })
vim.keymap.set("v", "<A-Down>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("i", "<A-Up>", "<Esc>:m .-2<CR>==gi", { desc = "Move line up" })
vim.keymap.set("i", "<A-Down>", "<Esc>:m .+1<CR>==gi", { desc = "Move line down" })

-- Duplicate lines (VSCode style)
vim.keymap.set("n", "<S-A-Down>", "yyp", { desc = "Duplicate line down" })
vim.keymap.set("n", "<S-A-Up>", "yyP", { desc = "Duplicate line up" })
vim.keymap.set("v", "<S-A-Down>", "ygv'>p", { desc = "Duplicate selection down" })
vim.keymap.set("v", "<S-A-Up>", "ygv'<P", { desc = "Duplicate selection up" })

-- Clear search highlighting
vim.keymap.set("n", "<Esc><Esc>", ":nohlsearch<CR>", { desc = "Clear search highlight" })

-- Better indenting
vim.keymap.set("v", "<", "<gv", { desc = "Indent left" })
vim.keymap.set("v", ">", ">gv", { desc = "Indent right" })

-- Paste over without yanking
vim.keymap.set("v", "p", '"_dP', { desc = "Paste without yank" })

-- disable formatting
vim.g.autoformat = false