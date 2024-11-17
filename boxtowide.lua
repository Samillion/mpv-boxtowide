--[[

    This script changes the aspect ratio of all 4:3 videos to 16:9.
    Big thanks to Argon-, I couldn't have done it without his help.

    More info: https://github.com/Samillion/mpv-boxtowide

--]]

local options = {
    -- target aspect ratio for conversion
    target_ratio = "16:9",

    -- usually 4:3 would only need 1.3333
    -- many old videos use weird ratios, this min/max range covers most of them
    min_ratio = 1.28,
    max_ratio = 1.39,

    -- file extensions the script will do a ratio check on
    video_exts = {
        "3g2", "3gp", "asf", "avi", "f4v", "flv", "m2t", "m2ts", "m4v", "mj2", 
        "mkv", "mov", "mp4", "mpeg", "mpe", "mpg", "mts", "ogv", "rmvb", "ts", 
        "webm", "wmv", "y4m"
    },

    -- regex to detect urls (for ytdl videos)
    url_pattern = "^%a+://",
}

local msg = require "mp.msg"

local function box_ratio(_, value)
    if value then
        if value >= options.min_ratio and value <= options.max_ratio then
            local video_track = mp.get_property_native("current-tracks/video")
            -- only apply on videos (second check in case of ytdl)
            if video_track and not video_track.image then
                mp.set_property("file-local-options/video-aspect-override", options.target_ratio)
                msg.info("Video aspect-ratio changed from 4:3 to " .. options.target_ratio)
            end
        end

        -- ensure single ratio check per file
        mp.unobserve_property(box_ratio)
    end
end

local function create_set(t)
    local set = {}
    for _, v in ipairs(t) do
        set[tostring(v):lower()] = true
    end
    return set
end

local list = create_set(options.video_exts)

local function path_check()
    local path = mp.get_property("path", "")
    local ext = path:match("%.([^%.]+)$") or "nomatch"

    if list[ext:lower()] or path:match(options.url_pattern) then
        mp.observe_property("video-params/aspect", "number", box_ratio)
    end
end

mp.register_event("start-file", path_check)
