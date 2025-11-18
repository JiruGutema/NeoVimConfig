# Neovim Configuration 

A clean, fast, and modern Neovim setup designed to feel familiar to VS Code users while delivering superior performance. Built entirely in Lua using Lazy.nvim as the plugin manager.

## Features

- VS Code Dark+ theme with perfect syntax highlighting (`vscode.nvim`)
- Official GitHub Copilot integration with custom keybindings
- Smart file explorer navigation (NvimTree) using Ctrl+h and Ctrl+l to switch between tree and editor
- Telescope fuzzy finder: Ctrl+p for files, Ctrl+f for project-wide search
- Full LSP support with automatic server installation via Mason
- Auto-formatting on save and intelligent auto-save
- VS Code-style line moving and duplication (Alt+Up/Down, Shift+Alt+Up/Down)
- Smooth scrolling, git signs, status line, and system clipboard integration
- No deprecated APIs — fully compatible with Neovim 0.10+ and nvim-lspconfig v2+

## Installation

### Requirements
- Neovim ≥ 0.10
- Node.js ≥ 18 (required for Copilot and several LSP servers)
- Git
- A Nerd Font (recommended: FiraCode Nerd Font or JetBrainsMono Nerd Font)

### Setup
```bash
git clone https://github.com/jirugutema/NeoVimConfig ~/.config/nvim
nvim
```
Lazy.nvim will download and install all plugins on first launch.

### GitHub Copilot
1. Open any file and enter insert mode
2. Follow the authentication prompt in your browser
3. Authentication persists across sessions

## Keybindings

| Mode   | Key              | Action                                   |
|--------|------------------|------------------------------------------|
| Normal | Ctrl+p           | Find files (Telescope)                   |
| Normal | Ctrl+f           | Live grep across project                 |
| Normal | <leader>n        | Toggle file explorer                     |
| Normal | Ctrl+h           | Focus file explorer                      |
| Normal | Ctrl+l           | Return to editor from explorer           |
| Normal | Ctrl+Shift+i     | Format current buffer                    |
| N/V/I  | Alt+Up/Down      | Move line(s) up/down                     |
| N/V    | Shift+Alt+Up/Down| Duplicate line(s)                        |
| Insert | jj               | Escape to Normal mode                    |
| Insert | Ctrl+J           | Accept Copilot suggestion                |
| Insert | Ctrl+] / Ctrl+[  | Cycle Copilot suggestions                |
| Insert | Ctrl+\           | Dismiss Copilot suggestion              |

## LSP Servers (automatically installed)

- ts_ls (TypeScript/JavaScript/React)
- pyright (Python)
- gopls (Go)
- omnisharp (C#)
- jdtls (Java)
- lua_ls (Lua)
- html, cssls, jsonls

## Contributing

Issues and pull requests are welcome. This configuration is intentionally kept minimal and performant.

## License

MIT License — feel free to use, modify, and distribute.

**Happy coding.**
