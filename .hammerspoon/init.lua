-- http://www.hammerspoon.org/go/

-- Configuration reloading
hs.hotkey.bind({"cmd", "ctrl"}, "R", function()
  hs.reload()
end)

local delay = hs.eventtap.keyRepeatDelay()
local function pressFn(mods, key)
    if key == nil then
        key = mods
        mods = {}
    end
    return function() hs.eventtap.keyStroke(mods, key, delay) end
end

local function remap(mods, key, pressFn)
    hs.hotkey.bind(mods, key, pressFn, nil, pressFn)
end

-- Emacs Mode
remap({'ctrl'}, 'h', pressFn('delete'))
remap({'ctrl'}, 'j', pressFn('return'))
remap({'ctrl'}, 'f', pressFn('right'))
remap({'ctrl'}, 'b', pressFn('left'))
remap({'ctrl'}, 'p', pressFn('up'))
remap({'ctrl'}, 'n', pressFn('down'))
