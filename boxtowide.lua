--[[

    This script changes the aspect ratio of all 4:3 videos to 16:9.
    Big thanks to Argon-, I couldn't have done it without his help.

    More info: https://github.com/Samillion/mpv-boxtowide

--]]
local msg = require 'mp.msg'

local function setBoxRatio(name, value)
    if value ~= nil then
        local videoTrack = mp.get_property_native('current-tracks/video')

        if videoTrack and not videoTrack.image and not videoTrack.albumart then
            if value >= 1.28 and value <= 1.39 then
                mp.set_property("file-local-options/video-aspect-override", "16:9")
                msg.info("Aspect-ratio changed from 4:3 to 16:9")
                mp.unobserve_property(setBoxRatio)
            end
        end
    end
end

local function Set(t)
    local set = {}
    for _, v in pairs(t) do set[v] = true end
    return set
end

local function prepareCheck()
    local path = mp.get_property("path", "")
    local ext = path:match("%.([^%.]+)$") or 'nomatch'
    local whitelist = Set {
        '3g2', '3gp', 'avi', 'flv', 'm2ts', 'm4v', 'mj2', 'mkv', 'mov',
        'mp4', 'mpeg', 'mpg', 'ogv', 'rmvb', 'ts', 'webm', 'wmv', 'y4m'
    }

    if whitelist[ext:lower()] or path:match('^%a+://') then
        mp.observe_property("video-params/aspect", "number", setBoxRatio)
    end
end

mp.register_event("start-file", prepareCheck)
