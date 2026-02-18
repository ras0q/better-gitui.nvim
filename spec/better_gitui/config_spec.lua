local function fresh()
    package.loaded["better_gitui._core.config"] = nil
    return require("better_gitui._core.config")
end

describe("config.get", function()
    it("raises an error before setup() is called", function()
        local config = fresh()
        assert.has_error(function()
            config.get()
        end, "better-gitui: call setup() before using the plugin")
    end)
end)

describe("config.setup", function()
    it("returns defaults when called with no arguments", function()
        local config = fresh()
        config.setup()
        local result = config.get()
        assert.same("gitui", result.gitui_path)
        assert.same(0.9, result.window.width_ratio)
        assert.same(0.9, result.window.height_ratio)
        assert.same("rounded", result.window.border)
    end)

    it("returns defaults when called with empty table", function()
        local config = fresh()
        config.setup({})
        assert.same("gitui", config.get().gitui_path)
    end)

    it("overrides top-level fields", function()
        local config = fresh()
        config.setup({ gitui_path = "/usr/local/bin/gitui" })
        assert.same("/usr/local/bin/gitui", config.get().gitui_path)
    end)

    it("deep-merges window options without clobbering other defaults", function()
        local config = fresh()
        config.setup({ window = { border = "double" } })
        local w = config.get().window
        assert.same("double", w.border)
        -- untouched defaults must survive the merge
        assert.same(0.9, w.width_ratio)
        assert.same(0.9, w.height_ratio)
    end)

    it("allows setup() to be called multiple times, last call wins", function()
        local config = fresh()
        config.setup({ gitui_path = "first" })
        config.setup({ gitui_path = "second" })
        assert.same("second", config.get().gitui_path)
    end)
end)
