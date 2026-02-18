# Changelog

## 1.0.0 (2026-02-18)


### ⚠ BREAKING CHANGES

* use mise task instead of makefile
* remove template files

### Features

* implement better-gitui.nvim ([139be93](https://github.com/ras0q/better-gitui.nvim/commit/139be936626ec91f6660805a276e9297a2265112))
* **tooling:** use luarocks path for busted in test target; document mise install in CONTRIBUTING ([2887443](https://github.com/ras0q/better-gitui.nvim/commit/288744331fa721960f11465bd9c91e1ddc277329))


### Bug Fixes

* **ci:** fix llscheck type warnings and urlchecker subfolder resolution ([8d6ec8f](https://github.com/ras0q/better-gitui.nvim/commit/8d6ec8f7860050529879baafb7a1b6364ab1972e))
* **ci:** resolve workflow failures in llscheck, urlchecker, coverage, and test jobs ([aa6ce43](https://github.com/ras0q/better-gitui.nvim/commit/aa6ce439f0efb93bda299818d301a3f93e248313))
* format ([a379bfa](https://github.com/ras0q/better-gitui.nvim/commit/a379bfac9f98ab2ff4f60ec7db3344d4ce63f7ab))


### Miscellaneous Chores

* remove template files ([0fcc18d](https://github.com/ras0q/better-gitui.nvim/commit/0fcc18d4a7ef79e3293f8e3cae601eba0d8fe20f))
* use mise task instead of makefile ([f9f62db](https://github.com/ras0q/better-gitui.nvim/commit/f9f62db934943cb59f6909484f51cc343193ee20))

## [Unreleased]

### Features

- Initial implementation: open gitui in a Neovim floating window
- Auto-generate gitui `.ron` theme from the current Neovim colorscheme
- Cache theme per colorscheme under `{stdpath("cache")}/gitui/`
- Regenerate theme automatically on `ColorScheme` events
