--[[

    This script changes the aspect ratio of all 4:3 videos to 16:9.
    Big thanks to Argon-, I couldn't have done it without his help.

    More info: https://github.com/Samillion/mpv-boxtowide

--]]

local video_exts = {
    "3g2", "3gp", "asf", "avi", "f4v", "flv", "m2t", "m2ts", "m4v", "mj2", 
    "mkv", "mov", "mp4", "mpeg", "mpe", "mpg", "mts", "ogv", "rmvb", "ts", 
    "webm", "wmv", "y4m"
}

local msg = require "mp.msg"

local function box_ratio(_, value)
    -- usually 4:3 would only need 1.3333
    -- many old videos use weird ratios, this range covers most of them
    if value and value >= 1.28 and value <= 1.39 then
        local video_track = mp.get_property_native("current-tracks/video")
        -- only apply on videos (second check in case of ytdl)
        if video_track and not (video_track.image or video_track.albumart) then
            mp.set_property("file-local-options/video-aspect-override", "16:9")
            msg.info("Aspect-ratio changed from 4:3 to 16:9")
            -- ensure single ratio check only per file
            mp.unobserve_property(box_ratio)
        end
    end
end

local function create_set(t)
    local set = {}
    for _, v in ipairs(t) do
        set[tostring(v):lower()] = true
    end
    return set
end

local list = create_set(video_exts)

local function path_check()
    local path = mp.get_property("path", "")
    local ext = path:match("%.([^%.]+)$") or "nomatch"

    -- regex would also match file://, but who uses that?
    if list[ext:lower()] or path:match("^%a+://") then
        mp.observe_property("video-params/aspect", "number", box_ratio)
    end
end

mp.register_event("start-file", path_check)
