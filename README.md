## BoxToWide
<img width="1483" height="302" alt="Terminal" src="https://github.com/user-attachments/assets/a647d587-b21a-4a71-b7d5-360a21df3105" />

This script automatically adjusts video aspect ratios in mpv. By default, it converts legacy 4:3 content to 16:9, but it can also handle other ratios using configurable range or precise checks.

It supports:
- Range-based detection for slightly off legacy ratios
- Accurate ratio detection with a tolerance for precise matching
- Flexible file/URL selection based on extensions or URLs
- Ideal for libraries with older or mixed aspect-ratio content, it streamlines widescreen conversion without manual intervention, while giving users full control over which checks to apply.

## Options
To adjust options, simply change the values inside `boxtowide.conf` (recommended) or adjust `local options` within the script.

```EditorConfig
# file extensions the script will check
# separate each with a comma
video_exts=3gp,asf,avi,flv,m4v,mkv,mov,mp4,mp4v,mpeg,mpg,mts,ogv,rmvb,ts,webm,wmv

# target aspect ratio for conversion
# common ratios:
# 4:3 (1.3333), 16:9 (1.7778), 16:10 (1.6)
# 1.85:1, 2.00:1, 2.20:1, 2.35:1, 2.39:1, 2.76:1
target_ratio=16:9

# ratio check type (one or both can be used)
# check if aspect is within min_ratio to max_ratio
range_check=yes

# check if aspect matches accurate_ratio + accurate_tolerance
accurate_check=yes

# many old videos use weird ratios; usually 4:3 is ~1.3333
min_ratio=1.28
max_ratio=1.39

# common decimal ratios:
# 1.3333 (4:3), 1.7778 (16:9), 1.6 (16:10)
# 1.5 (3:2), 1.25 (5:4), 1.85 (1.85:1), 2.0 (2.00:1)
# 2.35 (2.35:1), 2.39 (2.39:1 scope)
accurate_ratio=1.3333

# allowed deviation; 0 = exact match
accurate_tolerance=0.01

# regex to detect urls (e.g. ytdl videos)
# a simpler pattern: "^%a+://"
url_pattern=^[%a][%a%d+.-]*://
```

## How to install
Simply place `boxtowide.lua` in the corresponding mpv scripts location of your operating system:

- Windows: `%APPDATA%\mpv\scripts\` or `C:\users\USERNAME\AppData\Roaming\mpv\scripts\`
- Linux: `~/.config/mpv/scripts/` or `/home/USERNAME/.config/mpv/scripts/`
- Mac: `~/.config/mpv/scripts/` or `/Users/USERNAME/.config/mpv/scripts/`

> [!NOTE]
> More information about files locations can be found  [here](https://mpv.io/manual/master/#files)

```
📁 mpv/
├── 📁 script-opts/
│   └── 📄 boxtowide.conf
└── 📁 scripts/
    └── 📄 boxtowide.lua
```
