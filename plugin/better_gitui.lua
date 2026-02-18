local better_gitui = require("better_gitui")
local theme = require("better_gitui._core.theme")

vim.api.nvim_create_user_command("Gitui", function()
    better_gitui.launch()
end, { desc = "Launch gitui in a floating window with Neovim colorscheme-based theme" })

vim.api.nvim_create_autocmd("ColorScheme", {
    group = vim.api.nvim_create_augroup("BetterGituiThemeSync", { clear = true }),
    callback = function()
        vim.defer_fn(function()
            local ok, err = pcall(theme.write)
            if not ok then
                vim.notify("better-gitui: theme auto-update failed: " .. tostring(err), vim.log.levels.WARN)
            end
        end, 100)
    end,
})
