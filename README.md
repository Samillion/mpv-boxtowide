## mpv-boxtowide
![Terminal](https://github.com/user-attachments/assets/ee932972-4b86-494d-973e-a286e6cdf078)

This script detects if a video has a 4:3 aspect ratio and automatically adjusts it to 16:9 (wide).

It is designed for libraries with older 4:3 content, stretching them to 16:9 without manual intervention. The script aligns with my preference for a simple [mpv configuration](https://github.com/Samillion/mpv-conf) to fit this straightforward use case.

## Options
To adjust options, simply change the values inside `local options` within the script.

```lua
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
```

## How to install
Simply place `boxtowide.lua` in the corresponding mpv scripts location of your operating system:

- Windows: `%APPDATA%\mpv\scripts\` or `C:\users\USERNAME\AppData\Roaming\mpv\scripts\`
- Linux: `~/.config/mpv/scripts/` or `/home/USERNAME/.config/mpv/scripts/`
- Mac: `~/.config/mpv/scripts/` or `/Users/USERNAME/.config/mpv/scripts/`

> [!NOTE]
> More information about files locations can be found  [here](https://mpv.io/manual/master/#files)

```
config/mpv
│   input.conf
│   mpv.conf
│
└───scripts
        boxtowide.lua
```
