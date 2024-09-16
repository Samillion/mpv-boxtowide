--[[

This script changes the aspect ratio of all 4:3 videos to 16:9.
Big thanks to Argon-, I couldn't have done it without his help.

More info: https://github.com/Samillion/mpv-boxtowide

--]]

local extVideos = {
	'3g2', '3gp', 'avi', 'flv', 'm2ts', 'm4v', 'mj2', 'mkv', 'mov',
	'mp4', 'mpeg', 'mpg', 'ogv', 'rmvb', 'ts', 'webm', 'wmv', 'y4m'
}

local extImages = {	
	'avif', 'bmp', 'gif', 'j2k', 'jp2', 'jpeg', 'jpg', 'jxl', 'png',
	'svg', 'tga', 'tif', 'tiff', 'webp'
}

-- true to ignore changing aspect ratio for images
local ignoreImages = true

local msg = require 'mp.msg'
local utils = require 'mp.utils'

local function Set (t)
	local set = {}
	for _, v in pairs(t) do set[v] = true end
	return set
end

local function getExtension(value)
    return value:match("%.([^%.]+)$") or ''
end

local function setBoxRatio(name, value)
	if value ~= nil then
		if (value >= 1.28) and (value <= 1.39) then
			mp.set_property("video-aspect-override", "16:9")
			msg.info("Aspect-ratio changed from 4:3 to 16:9")
		end
		
		mp.unobserve_property(setBoxRatio)
	end
end

extVideos, extImages = Set(extVideos), Set(extImages)

local function prepareRatioCheck()
	local path = mp.get_property("path", "")
	local dir, filename = utils.split_path(path)

	if extVideos[string.lower(getExtension(filename))] or string.match(path, "^%a+://") then
		mp.set_property("video-aspect-override", "-1")
		mp.observe_property("video-params/aspect", "number", setBoxRatio)
	elseif extImages[string.lower(getExtension(filename))] and ignoreImages then
		mp.set_property("video-aspect-override", "-1")
	end
end

mp.register_event("start-file", prepareRatioCheck)
