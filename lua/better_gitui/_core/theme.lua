local M = {}

local function hl_to_hex(hl_name, attr)
    local ok, hl = pcall(vim.api.nvim_get_hl, 0, { name = hl_name, link = false })
    if not ok or not hl or not hl[attr] then
        return nil
    end
    return string.format("#%06x", hl[attr])
end

local function get_cache_dir()
    local cache_home = vim.fn.stdpath("cache")
    local gitui_cache = cache_home .. "/gitui"
    vim.fn.mkdir(gitui_cache, "p")
    return gitui_cache
end

function M.get_theme_path()
    local colorscheme = vim.g.colors_name or "default"
    return get_cache_dir() .. "/theme_" .. colorscheme .. ".ron"
end

function M.generate()
    local theme = {}

    theme.selection_bg = hl_to_hex("Visual", "bg") or hl_to_hex("CursorLine", "bg")
    theme.selection_fg = hl_to_hex("Visual", "fg")
    theme.command_fg = hl_to_hex("Normal", "fg")
    theme.cmdbar_bg = hl_to_hex("StatusLine", "bg")
    theme.cmdbar_extra_lines_bg = hl_to_hex("StatusLine", "bg")
    theme.disabled_fg = hl_to_hex("Comment", "fg")
    theme.diff_line_add = hl_to_hex("DiffAdd", "fg") or hl_to_hex("diffAdded", "fg")
    theme.diff_line_delete = hl_to_hex("DiffDelete", "fg") or hl_to_hex("diffRemoved", "fg")
    theme.diff_file_added = hl_to_hex("DiffAdd", "fg") or hl_to_hex("diffAdded", "fg")
    theme.diff_file_removed = hl_to_hex("DiffDelete", "fg") or hl_to_hex("diffRemoved", "fg")
    theme.diff_file_modified = hl_to_hex("DiffChange", "fg") or hl_to_hex("diffChanged", "fg")
    theme.diff_file_moved = hl_to_hex("DiffText", "fg")
    theme.commit_hash = hl_to_hex("Constant", "fg") or hl_to_hex("Number", "fg")
    theme.commit_time = hl_to_hex("Comment", "fg")
    theme.commit_author = hl_to_hex("String", "fg")
    theme.tag_fg = hl_to_hex("Tag", "fg") or hl_to_hex("Label", "fg")
    theme.branch_fg = hl_to_hex("Directory", "fg") or hl_to_hex("Function", "fg")
    theme.danger_fg = hl_to_hex("ErrorMsg", "fg") or hl_to_hex("Error", "fg")
    theme.push_gauge_bg = hl_to_hex("PmenuSel", "bg") or hl_to_hex("Visual", "bg")
    theme.push_gauge_fg = hl_to_hex("PmenuSel", "fg") or hl_to_hex("Visual", "fg")
    theme.selected_tab = hl_to_hex("TabLineSel", "fg")
    theme.block_title_focused = hl_to_hex("Title", "fg")

    return theme
end

function M.format_ron(theme, colorscheme)
    local lines = {
        "(",
        string.format("    /* Generated from Neovim colorscheme: %s */", colorscheme or "unknown"),
    }

    for key, value in pairs(theme) do
        if value then
            table.insert(lines, string.format('    %s: Some("%s"),', key, value))
        end
    end

    table.insert(lines, ")")
    return table.concat(lines, "\n")
end

function M.write()
    local colorscheme = vim.g.colors_name or "default"
    local theme_path = M.get_theme_path()

    local ok, theme = pcall(M.generate)
    if not ok then
        vim.notify("Failed to generate theme: " .. tostring(theme), vim.log.levels.ERROR)
        return nil
    end

    local content = M.format_ron(theme, colorscheme)

    local file, err = io.open(theme_path, "w")
    if not file then
        vim.notify("Failed to write theme file: " .. tostring(err), vim.log.levels.ERROR)
        return nil
    end

    file:write(content)
    file:close()

    return theme_path
end

return M
