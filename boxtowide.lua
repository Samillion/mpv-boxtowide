--[[

This script changes the aspect ratio of all 4:3 videos to 16:9.
Big thanks to Argon-, I couldn't have done it without his help.

More info: https://github.com/Samillion/mpv-boxtowide

--]]
local msg = require 'mp.msg'

local function setBoxRatio(name, value)
	if value ~= nil then
		if (value >= 1.28) and (value <= 1.39) then
			mp.set_property("file-local-options/video-aspect-override", "16:9")
			msg.info("Aspect-ratio changed from 4:3 to 16:9")
		end
		
		mp.unobserve_property(setBoxRatio)
	end
end

local function prepareCheck()
	local path = mp.get_property("path", "")

	if not mp.get_property_native('current-tracks/video/image') and not mp.get_property_native('current-tracks/video/albumart') then
		if mp.get_property_native('vid') or string.match(path, "^%a+://") then
			mp.observe_property("video-params/aspect", "number", setBoxRatio)
		end
	end
end

mp.register_event("video-reconfig", prepareCheck)
