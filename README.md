# better-gitui.nvim

Open [gitui](https://github.com/extrawurst/gitui) in a Neovim floating window,
automatically themed to match your current colorscheme.

| <!-- --> | <!-- --> |
|---|---|
| Build Status | [![unittests](https://img.shields.io/github/actions/workflow/status/ras0q/better-gitui.nvim/test.yml?branch=main&style=for-the-badge&label=Unittests)](https://github.com/ras0q/better-gitui.nvim/actions/workflows/test.yml) [![documentation](https://img.shields.io/github/actions/workflow/status/ras0q/better-gitui.nvim/documentation.yml?branch=main&style=for-the-badge&label=Documentation)](https://github.com/ras0q/better-gitui.nvim/actions/workflows/documentation.yml) [![luacheck](https://img.shields.io/github/actions/workflow/status/ras0q/better-gitui.nvim/luacheck.yml?branch=main&style=for-the-badge&label=Luacheck)](https://github.com/ras0q/better-gitui.nvim/actions/workflows/luacheck.yml) [![stylua](https://img.shields.io/github/actions/workflow/status/ras0q/better-gitui.nvim/stylua.yml?branch=main&style=for-the-badge&label=Stylua)](https://github.com/ras0q/better-gitui.nvim/actions/workflows/stylua.yml) |
| License | [![License-MIT](https://img.shields.io/badge/License-MIT-blue?style=for-the-badge)](https://github.com/ras0q/better-gitui.nvim/blob/main/LICENSE) |

## Features

- Opens gitui in a centered floating window
- Auto-generates a gitui theme from your active Neovim colorscheme
- Theme is cached per colorscheme and regenerated on `ColorScheme` events
- No external Lua dependencies beyond Neovim itself

## Requirements

- Neovim >= 0.10.0
- [`gitui`](https://github.com/extrawurst/gitui) available in your `$PATH`

## Installation

[lazy.nvim](https://github.com/folke/lazy.nvim)

```lua
{
    "ras0q/better-gitui.nvim",
    version = "v1.*",
}
```

## Usage

```vim
:Gitui
```

Opens gitui in a floating window. Running `:Gitui` again while the window is open closes it.

**Keymaps inside the gitui window:**

| Key | Action |
|---|---|
| `<Esc>` | Exit terminal mode |
| `q` | Close the window |

**Recommended keymap (add to your config):**

```lua
vim.keymap.set("n", "<leader>g", "<Cmd>Gitui<CR>", { desc = "Open gitui" })
```

## How It Works

When `:Gitui` is called, the plugin:

1. Resolves a theme file path at `{stdpath("cache")}/gitui/theme_{colorscheme}.ron`
2. If the file does not exist, generates a `.ron` theme by reading highlight groups from
   the current Neovim colorscheme and writes it to disk.
3. Launches `gitui -t <theme_path>` inside a terminal buffer in a floating window.

On every `ColorScheme` event the theme for the new colorscheme is regenerated automatically
(with a 100 ms debounce).

## Minimal Reproduction

If you encounter a bug, please reproduce it with the minimal config below before filing an issue.

Save this to a file (e.g. `/tmp/repro.lua`) and run:

```sh
nvim --clean -u /tmp/repro.lua
```

```lua
-- /tmp/repro.lua
vim.opt.runtimepath:append("/path/to/better-gitui.nvim")
vim.cmd("runtime plugin/better_gitui.lua")

-- Reproduce the issue here, e.g.:
-- vim.cmd("Gitui")
```

Replace `/path/to/better-gitui.nvim` with the actual path where the plugin is installed
(e.g. `~/.local/share/nvim/lazy/better-gitui.nvim`).

## Contributing

See [CONTRIBUTING.md](CONTRIBUTING.md) for development setup, testing, and coverage instructions.

## Tracking Updates

See [CHANGELOG.md](CHANGELOG.md) for release notes.
