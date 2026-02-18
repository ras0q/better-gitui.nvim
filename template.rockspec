local git_ref = "$git_ref"
local modrev = "$modrev"
local specrev = "$specrev"

local repo_url = "$repo_url"

rockspec_format = "3.0"
package = "better-gitui.nvim"
version = modrev .. "-" .. specrev

local user = "ras0q"

description = {
    homepage = "https://github.com/" .. user .. "/" .. package,
    labels = { "neovim", "neovim-plugin", "gitui" },
    license = "MIT",
    summary = "A Neovim plugin to open gitui in a floating window with your current colorscheme",
}

dependencies = {
    "lua >= 5.1, < 6.0",
}

test_dependencies = {
    "busted >= 2.0, < 3.0",
    "lua >= 5.1, < 6.0",
}

test = { type = "busted" }

source = {
    url = repo_url .. "/archive/" .. git_ref .. ".zip",
    dir = "$repo_name-" .. "$archive_dir_suffix",
}

if modrev == "scm" or modrev == "dev" then
    source = {
        url = repo_url:gsub("https", "git"),
    }
end

build = {
    type = "builtin",
    copy_directories = $copy_directories,
}
