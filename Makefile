.PHONY: download-dependencies llscheck luacheck stylua test test-better-gitui

ifeq ($(OS),Windows_NT)
    IGNORE_EXISTING =
else
    IGNORE_EXISTING = 2> /dev/null || true
endif

CONFIGURATION = .luarc.json

download-dependencies:
	git clone git@github.com:Bilal2453/luvit-meta.git .dependencies/luvit-meta $(IGNORE_EXISTING)
	git clone git@github.com:LuaCATS/busted.git .dependencies/busted $(IGNORE_EXISTING)
	git clone git@github.com:LuaCATS/luassert.git .dependencies/luassert $(IGNORE_EXISTING)

llscheck: download-dependencies
	VIMRUNTIME="`nvim --clean --headless --cmd 'lua io.write(os.getenv("VIMRUNTIME"))' --cmd 'quit'`" llscheck --configpath $(CONFIGURATION) .

luacheck:
	luacheck lua plugin scripts spec

check-stylua:
	stylua lua plugin scripts spec --color always --check

stylua:
	stylua lua plugin scripts spec

check-mdformat:
	python -m mdformat --check README.md CONTRIBUTING.md

mdformat:
	python -m mdformat README.md CONTRIBUTING.md

test:
	busted spec/better_gitui/

# IMPORTANT: Make sure to run this first
# ```
# luarocks install busted --local
# luarocks install luacov --local
# luarocks install luacov-multiple --local
# ```
#
coverage-html:
	nvim -u NONE -U NONE -N -i NONE --headless -c "luafile scripts/luacov.lua" -c "quit"
	luacov --reporter multiple.html
