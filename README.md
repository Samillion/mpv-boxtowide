# mpv-boxtowide
This script will check if the video file has a 4:3 aspect ratio (box) and if so, it will change it to 16:9 (wide).

It also supports auto aspect ratio change for URLs/Streams running with `youtube-dl/yt-dlp` on mpv.

Its intended purpose is for videos or libraries with old 4:3 aspect ratio content. Instead of having black bars on the sides or manually changing the aspect ratio every time, it will stretch it to 16:9 aspect ratio automatically.

Works well with a mixed aspect ratio playlist. It will only change the aspect ratio of 4:3 videos, leaving the rest to their default aspect ratio.

# How to install
Simply place `boxtowide.lua` in the corresponding mpv scripts location of your operating system:

- Windows: `%APPDATA%\mpv\scripts\` or `C:\users\USERNAME\AppData\Roaming\mpv\scripts\`
- Linux: `~/.config/mpv/scripts/` or `/home/USERNAME/.config/mpv/scripts/`
- Mac: `~/.config/mpv/scripts/` or `/Users/USERNAME/.config/mpv/scripts/`

# How to uninstall
The script doesn't write or alter configuration files, so removing the `boxtowide.lua` script from the mpv scripts folder is all that is needed to uninstall/disable.

# Changes to mpv made by the script
This script adds parameters to mpv, such as `--video-aspect-override` to `-1` (default) to accurately check and change aspect ratio if needed. If you have something in `mpv.conf`, scripts or in commandline that changes `--video-aspect-override` or `--video-params/aspect`, it will be affected.

You'll still be able to manually change the aspect ratio afterwards during playback. For example if you have a keybind set within `input.conf` to cycle through aspect ratio values like:

`CTRL+a cycle-values video-aspect-override "16:9" "16:10" "4:3" "2.35:1"`
