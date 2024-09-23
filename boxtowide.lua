--[[

This script changes the aspect ratio of all 4:3 videos to 16:9.
Big thanks to Argon-, I couldn't have done it without his help.

More info: https://github.com/Samillion/mpv-boxtowide

--]]
local msg = require 'mp.msg'
local utils = require 'mp.utils'

local function setBoxRatio(name, value)
	if value ~= nil then
		if not mp.get_property_native('current-tracks/video/image') and not mp.get_property_native('current-tracks/video/albumart') then
			if (value >= 1.28) and (value <= 1.39) then
				mp.set_property("file-local-options/video-aspect-override", "16:9")
				msg.info("Aspect-ratio changed from 4:3 to 16:9")
			end
		end
		
		mp.unobserve_property(setBoxRatio)
	end
end

local function Set(t)
    local set = {}
    for _, v in pairs(t) do set[v] = true end
    return set
end

local function prepareCheck()
	local path = mp.get_property("path", "")
	local dir, filename = utils.split_path(path)
	local ext = filename:lower():match("%.([^%.]+)$") or ''
	local blacklist = { 'apng', 'avif', 'gif', 'webp' }
	
	if not Set(blacklist)[ext] then
		mp.observe_property("video-params/aspect", "number", setBoxRatio)
	end
end

mp.register_event("start-file", prepareCheck)
