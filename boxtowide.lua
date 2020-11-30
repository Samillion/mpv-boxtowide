--[[

This script changes the aspect ratio of all 4:3 videos to 16:9.

It does so by first checking if the file is a video by doing a
file extension check or if it's a video stream with ytdl, then
checks the video parameter aspect ratio, if the aspect ratio is
4:3 it changes it to 16:9 then ends the script.

Big thanks to Argon-, I couldn't have done it without his help.
Also thanks to autoload authors, specifically for these parts:
function Set(t), EXTENSIONS, function get_extension(path)

--]]

-- Set this to false to disable the script
local ratioFix = true

-- Set this to false to disable resetting aspect ratio to original for images that could be in video playlists/folders.
local imagesFix = true

local msg = require 'mp.msg'
local utils = require 'mp.utils'

local function Set (t)
	local set = {}
	for _, v in pairs(t) do set[v] = true end
	return set
end

local EXTENSIONS = Set {
	'mkv', 'avi', 'mp4', 'ogv', 'webm', 'rmvb', 'flv', 'wmv', 'mpeg', 'mpg', 'm4v', '3gp', 'ts'
}

local EXTENSIONS_IMAGES = Set {
    'jpg', 'jpeg', 'png', 'tif', 'tiff', 'gif', 'webp', 'svg', 'bmp'
}

local function getExtension(path)
	match = string.match(path, "%.([^%.]+)$" )
	if match == nil then
		return ''
	else
		return match
	end
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
		msg.info("Finished check, script no longer running.")
	end
end

local function prepareRatioCheck()
	local path = mp.get_property("path", "")
	local dir, filename = utils.split_path(path)

	if EXTENSIONS[string.lower(getExtension(filename))] or string.match(string.lower(path), "^(https?://)") then
		mp.set_property("video-aspect-override", "-1")
		msg.info("Aspect-ratio has been reset to default to initialize ratio check.")
		
		mp.observe_property("video-params/aspect", "number", setBoxRatio)
		msg.info("Observing aspect-ratio value...")
		
	elseif EXTENSIONS_IMAGES[string.lower(getExtension(filename))] and imagesFix then
		mp.set_property("video-aspect-override", "-1")
		msg.info("Image file detected. Aspect ratio has been reset to original.")
	else
		msg.info("Not video file, script didn't run.")
	end
end

if ratioFix then
	mp.register_event("start-file", prepareRatioCheck)
end
