local config = require("better_gitui._core.config")
local theme = require("better_gitui._core.theme")
local window = require("better_gitui._core.window")

local M = {}

--- @param opts? BetterGituiConfig
function M.setup(opts)
    config.setup(opts)
end

function M.launch()
    window.launch()
end

function M.write_theme()
    return theme.write()
end

function M.get_theme_path()
    return theme.get_theme_path()
end

function M.close()
    window.close()
end

return M


