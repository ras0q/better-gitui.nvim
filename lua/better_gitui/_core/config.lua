local M = {}

--- @class BetterGituiWindowConfig
--- @field width_ratio number Fraction of editor width (0 < n <= 1)
--- @field height_ratio number Fraction of editor height (0 < n <= 1)
--- @field border string|string[] Border style passed to nvim_open_win

--- @class BetterGituiConfig
--- @field gitui_path string Path or name of the gitui executable
--- @field window BetterGituiWindowConfig

--- @type BetterGituiConfig
local _defaults = {
    gitui_path = "gitui",
    window = {
        width_ratio = 0.9,
        height_ratio = 0.9,
        border = "rounded",
    },
}

--- @type BetterGituiConfig|nil
local _config = nil

--- @param opts? BetterGituiConfig
function M.setup(opts)
    _config = vim.tbl_deep_extend("force", _defaults, opts or {})
end

--- Raises an error when called before setup().
--- @return BetterGituiConfig
function M.get()
    assert(_config ~= nil, "better-gitui: call setup() before using the plugin")
    return _config
end

return M
