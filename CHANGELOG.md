# Changelog

## [Unreleased]

### Features

- Initial implementation: open gitui in a Neovim floating window
- Auto-generate gitui `.ron` theme from the current Neovim colorscheme
- Cache theme per colorscheme under `{stdpath("cache")}/gitui/`
- Regenerate theme automatically on `ColorScheme` events

