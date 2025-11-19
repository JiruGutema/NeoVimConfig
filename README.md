# Neovim Configuration

A clean, fast, and modern vscode like Neovim setup designed to feel familiar to VS Code users while delivering superior performance. 
Built entirely in Lua using Lazy.nvim as the plugin manager.
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/f9d6f281-28f4-47ad-a6f9-c482618ee94e" />
<img width="1920" height="1080" alt="image" src="https://github.com/user-attachments/assets/faa5edf9-5339-4454-82ad-0f7fabd1c3f0" />

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
