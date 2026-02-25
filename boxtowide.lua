--[[

    This script changes the aspect ratio of all 4:3 videos to 16:9.
    Big thanks to Argon-, I couldn't have done it without his help.

    More info: https://github.com/Samillion/mpv-boxtowide

--]]

local options = {
    -- file extensions the script will check
    -- separate each with a comma
    video_exts = "3gp,asf,avi,flv,m4v,mkv,mov,mp4,mp4v,mpeg,mpg,mts,ogv,rmvb,ts,webm,wmv",

    -- target aspect ratio for conversion
    -- common ratios:
    -- 4:3 (1.3333), 16:9 (1.7778), 16:10 (1.6)
    -- 1.85:1, 2.00:1, 2.20:1, 2.35:1, 2.39:1, 2.76:1
    target_ratio = "16:9",

    -- ratio check type (one or both can be used)
    -- check if aspect is within min_ratio to max_ratio
    range_check = true,

    -- check if aspect matches accurate_ratio + accurate_tolerance
    accurate_check = true,

    -- many old videos use weird ratios; usually 4:3 is ~1.3333
    min_ratio = 1.28,
    max_ratio = 1.39,

    -- common decimal ratios:
    -- 1.3333 (4:3), 1.7778 (16:9), 1.6 (16:10)
    -- 1.5 (3:2), 1.25 (5:4), 1.85 (1.85:1), 2.0 (2.00:1)
    -- 2.35 (2.35:1), 2.39 (2.39:1 scope)
    accurate_ratio = 1.3333,

    -- allowed deviation; 0 = exact match
    accurate_tolerance = 0.01,

    -- regex to detect urls (e.g. ytdl videos)
    -- simpler pattern: "^%a+://"
    url_pattern = "^[%a][%a%d+.-]*://",
}

local msg = require "mp.msg"
local checked = false
require 'mp.options'.read_options(options, "boxtowide")

local function extension_matches(path, extensions)
    if not path or not extensions or path:match(options.url_pattern) then
        return false
    end

    local ext = path:match("%.([^%.]+)$")
    if not ext then return false end

    ext = ext:lower()

    for listed_ext in string.gmatch(extensions, '([^,]+)') do
        listed_ext = listed_ext:match("^%s*(.-)%s*$"):lower()
        if ext == listed_ext then
            return true
        end
    end

    return false
end

local function box_ratio(_, value)
    if checked or not value or value <= 0 then return end
    checked = true

    local in_range = options.range_check and value >= options.min_ratio and value <= options.max_ratio
    local accurate_match = false

    if options.accurate_check and options.accurate_ratio and options.accurate_ratio > 0 then
        accurate_match = math.abs(value - options.accurate_ratio) <= options.accurate_tolerance
    end

    if in_range or accurate_match then
        local video_track = mp.get_property_native("current-tracks/video")

        if video_track and not video_track.image then
            mp.set_property("file-local-options/video-aspect-override", options.target_ratio)
            local changed = string.format(
                "Aspect ratio %.4f matched (range=%s, accurate=%s). Changed to %s", 
                value, tostring(in_range), tostring(accurate_match), options.target_ratio
            )
            msg.info(changed)
        end
    end

    mp.unobserve_property(box_ratio)
end

local function path_check()
    checked = false
    local path = mp.get_property("path", "")
    if not path then return end

    if extension_matches(path, options.video_exts) or path:match(options.url_pattern) then
        mp.observe_property("video-params/aspect", "number", box_ratio)
    end
end

mp.register_event("start-file", path_check)
