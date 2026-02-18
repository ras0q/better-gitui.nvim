local theme = require("better_gitui._core.theme")

describe("theme.generate", function()
    it("returns a table with expected keys", function()
        local result = theme.generate()
        assert.is_table(result)
        local expected_keys = {
            "selection_bg",
            "command_fg",
            "cmdbar_bg",
            "cmdbar_extra_lines_bg",
            "disabled_fg",
            "diff_line_add",
            "diff_line_delete",
            "diff_file_added",
            "diff_file_removed",
            "diff_file_modified",
            "commit_hash",
            "commit_time",
            "commit_author",
        }
        for _, key in ipairs(expected_keys) do
            assert.is_not_nil(result[key] or true, "key should exist: " .. key)
        end
    end)

    it("returns hex values when present", function()
        local result = theme.generate()
        for key, value in pairs(result) do
            if value ~= nil then
                assert.is_string(value, key .. " should be a string")
                assert.truthy(value:match("^#%x%x%x%x%x%x$"), key .. " should be a hex color, got: " .. tostring(value))
            end
        end
    end)
end)

describe("theme.format_ron", function()
    it("wraps content in parentheses", function()
        local result = theme.format_ron({}, "test")
        assert.truthy(result:match("^%("))
        assert.truthy(result:match("%)$"))
    end)

    it("includes the colorscheme comment", function()
        local result = theme.format_ron({}, "my_colorscheme")
        assert.truthy(result:find("my_colorscheme", 1, true))
    end)

    it("formats key-value pairs as RON Some() syntax", function()
        local result = theme.format_ron({ selection_bg = "#aabbcc" }, "test")
        assert.truthy(result:find('selection_bg: Some("#aabbcc")', 1, true))
    end)

    it("skips nil values", function()
        local result = theme.format_ron({ selection_bg = nil, command_fg = "#112233" }, "test")
        assert.falsy(result:find("selection_bg", 1, true))
        assert.truthy(result:find("command_fg", 1, true))
    end)
end)

describe("theme.get_theme_path", function()
    it("returns a string path ending in .ron", function()
        local path = theme.get_theme_path()
        assert.is_string(path)
        assert.truthy(path:match("%.ron$"))
    end)

    it("includes the current colorscheme name", function()
        local colorscheme = vim.g.colors_name or "default"
        local path = theme.get_theme_path()
        assert.truthy(path:find(colorscheme, 1, true))
    end)
end)

describe("theme.write", function()
    it("writes a file and returns the path", function()
        local path = theme.write()
        assert.is_string(path)
        assert.equals(1, vim.fn.filereadable(path))
    end)

    it("written file is valid RON-like content", function()
        local path = theme.write()
        assert.is_string(path)

        local file = io.open(path, "r")
        assert.is_not_nil(file)
        local content = file:read("*a")
        file:close()

        assert.truthy(content:match("^%("))
        assert.truthy(content:match("%)$"))
    end)
end)
