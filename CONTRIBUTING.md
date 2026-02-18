# Contributing

## Development Setup

Clone the repository, install mise-managed tools, and install LSP dependencies:

```sh
git clone https://github.com/ras0q/better-gitui.nvim
cd better-gitui.nvim
mise install
make download-dependencies
```

`mise install` installs `stylua`, `neovim`, `lua-language-server`, and `uv` as declared in
`mise.toml`.

`make download-dependencies` clones type stubs for busted/luassert and luvit-meta into
`.dependencies/`.

## Testing

### Install test runner

```sh
luarocks install busted --local
```

Activate the luarocks environment once per shell session:

```sh
eval $(luarocks path --bin)
```

### Run tests

```sh
make test
# or directly
busted spec/better_gitui/
```

### Watch mode (optional)

```sh
busted --watch spec/better_gitui/
```

## Coverage

Install the additional dependencies:

```sh
luarocks install luacov --local
luarocks install luacov-multiple --local
```

Generate an HTML coverage report:

```sh
make coverage-html
```

View the report:

```sh
(cd luacov_html && python -m http.server)
```

Open `http://localhost:8000` in a browser.

## Linting & Formatting

```sh
make luacheck       # static analysis
make check-stylua   # formatting check
make stylua         # apply formatting
```

## Minimal Reproduction

When debugging, run Neovim with only this plugin loaded:

```sh
nvim --clean -u /tmp/repro.lua
```

```lua
-- /tmp/repro.lua
vim.opt.runtimepath:append(vim.fn.expand("~/path/to/better-gitui.nvim"))
vim.cmd("runtime plugin/better_gitui.lua")

-- trigger the issue:
vim.cmd("Gitui")
```

## Commit Style

Follow [Conventional Commits](https://www.conventionalcommits.org/):

```
feat: add X
fix(theme): handle missing highlight group
docs: update README
```
