--[[

This script changes the aspect ratio of all 4:3 videos to 16:9.
Big thanks to Argon-, I couldn't have done it without his help.

More info: https://github.com/Samillion/mpv-boxtowide

--]]

-- Set this to false to disable the script
local ratioFix = true

-- True: Do not alter image files aspect ratio.
local imagesFix = true

local extVideos = {
	'mkv', 'avi', 'mp4', 'ogv', 'webm', 'rmvb', 'flv', 'wmv', 'mpeg', 'mpg', 'm4v', '3gp', 'ts'
}

local extImages = {
    'jpg', 'jpeg', 'png', 'tif', 'tiff', 'gif', 'webp', 'svg', 'bmp'
}

local msg = require 'mp.msg'
local utils = require 'mp.utils'

local function Set (t)
	local set = {}
	for _, v in pairs(t) do set[v] = true end
	return set
end

extVideos, extImages = Set(extVideos), Set(extImages)

local function getExtension(value)
    return value:match("%.([^%.]+)$") or ''
end

local function setBoxRatio(name, value)
	if value ~= nil then
		if (value >= 1.28) and (value <= 1.39) then
			mp.set_property("video-aspect-override", "16:9")
			msg.info("Aspect-ratio changed from 4:3 to 16:9")
		else
			msg.info("Aspect-ratio unchanged, video is not 4:3.")
		end
		
		mp.unobserve_property(setBoxRatio)
	end
end

local function prepareRatioCheck()
	local path = mp.get_property("path", "")
	local dir, filename = utils.split_path(path)

	if extVideos[string.lower(getExtension(filename))] or string.match(string.lower(path), "^%a+://") then
		mp.set_property("video-aspect-override", "-1")
		msg.info("Aspect-ratio has been reset to default to initialize ratio check.")
		
		mp.observe_property("video-params/aspect", "number", setBoxRatio)
		msg.info("Observing aspect-ratio value...")
	elseif extImages[string.lower(getExtension(filename))] and imagesFix then
		mp.set_property("video-aspect-override", "-1")
		msg.info("Image file detected. Aspect ratio has been reset to original.")
	end
end

if ratioFix then
	mp.register_event("start-file", prepareRatioCheck)
end
