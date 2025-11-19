# Neovim Configuration

A clean, fast, and modern vscode like Neovim setup designed to feel familiar to VS Code users while delivering superior performance. 
Built entirely in Lua using Lazy.nvim as the plugin manager.

## Installation

### Requirements

- Neovim ≥ 0.10
- Node.js ≥ 18 (required for Copilot and several LSP servers)
- Git
- A Nerd Font (recommended: FiraCode Nerd Font or JetBrainsMono Nerd Font)

### Setup

```bash
git clone https://github.com/jirugutema/NeoVimConfig ~/.config/nvim
rm -rf ~/.config/nvim/.git
rm -rf ~/.local/share/nvim
nvim
```

Lazy.nvim will download and install all plugins on first launch.

## Keybindings

Original Lazyvim keybindings are used for most operations.

- <http://www.lazyvim.org/keymaps>
- key bindingings can be found under config/keymaps.lua

## Contributing

Issues and pull requests are welcome. This configuration is intentionally kept minimal and performant.

## License

MIT License — feel free to use, modify, and distribute.

**Happy coding.**
