local theme = require("better_gitui._core.theme")

local M = {}

local _buf = nil
local _win = nil

local function _close()
    if _win and vim.api.nvim_win_is_valid(_win) then
        vim.api.nvim_win_close(_win, true)
    end
    if _buf and vim.api.nvim_buf_is_valid(_buf) then
        vim.api.nvim_buf_delete(_buf, { force = true })
    end
    _win = nil
    _buf = nil
end

local function _open_window()
    local width = vim.o.columns
    local height = vim.o.lines
    local win_width = math.floor(width * 0.9)
    local win_height = math.floor(height * 0.9)
    local row = math.floor((height - win_height) / 2)
    local col = math.floor((width - win_width) / 2)

    local buf = vim.api.nvim_create_buf(false, true)
    if not buf then
        vim.notify("Failed to create buffer", vim.log.levels.ERROR)
        return nil, nil
    end

    local ok, win = pcall(vim.api.nvim_open_win, buf, true, {
        relative = "editor",
        width = win_width,
        height = win_height,
        row = row,
        col = col,
        style = "minimal",
        border = "rounded",
    })

    if not ok then
        vim.notify("Failed to open window: " .. tostring(win), vim.log.levels.ERROR)
        vim.api.nvim_buf_delete(buf, { force = true })
        return nil, nil
    end

    return buf, win
end

function M.launch()
    local theme_path = theme.get_theme_path()

    if vim.fn.filereadable(theme_path) == 0 then
        theme_path = theme.write()
        if not theme_path then
            vim.notify("Failed to generate theme, launching gitui with default theme", vim.log.levels.WARN)
            theme_path = nil
        end
    end

    if _win and vim.api.nvim_win_is_valid(_win) then
        _close()
        return
    end

    local buf, win = _open_window()
    if not buf or not win then
        return
    end

    _buf = buf
    _win = win

    local cmd = { "gitui" }
    if theme_path then
        vim.list_extend(cmd, { "-t", theme_path })
    end

    local job_ok, job_id = pcall(vim.fn.jobstart, cmd, {
        term = true,
        on_exit = function()
            vim.schedule(_close)
        end,
    })

    if not job_ok or job_id <= 0 then
        vim.notify("Failed to start gitui: " .. tostring(job_id), vim.log.levels.ERROR)
        _close()
        return
    end

    vim.cmd("startinsert")

    vim.api.nvim_buf_set_keymap(_buf, "t", "<Esc>", "<C-\\><C-n>", { noremap = true, silent = true })
    vim.api.nvim_buf_set_keymap(
        _buf,
        "n",
        "q",
        "<Cmd>lua require('better_gitui._core.window').close()<CR>",
        { noremap = true, silent = true }
    )
end

function M.close()
    _close()
end

return M
