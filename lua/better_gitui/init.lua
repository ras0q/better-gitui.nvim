local theme = require("better_gitui._core.theme")
local window = require("better_gitui._core.window")

local M = {}

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
