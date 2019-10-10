# mpv-boxtowide
This script will check if the video file has a 4:3 aspect ratio (box) and if so, it will change it to 16:9 (wide).

Its intended purpose is for video files or libraries with old 4:3 aspect ratio content. Instead of having black bars on the sides or manually changing the aspect ratio every time, it will stretch it to 16:9 aspect ratio automatically.

Works well with a mixed aspect ratio playlist. It will only change the aspect ratio of 4:3 video files, leaving the rest to their default aspect ratio.

# How to install
Simply place `boxtowide.lua` in the corresponding mpv scripts location of your operating system:

- Windows: `%APPDATA%\mpv\scripts\` or `C:\users\USERNAME\AppData\Roaming\mpv\scripts\`
- Linux: `~/.config/mpv/scripts/` or `/home/USERNAME/.config/mpv/scripts/`
- Mac: `~/.config/mpv/scripts/` or `/Users/USERNAME/.config/mpv/scripts/`

# Changes to mpv configuration made by the script
This script changes `--video-aspect-override` to `-1` (default) to accurately check and change aspect ratio if needed. If you have something in `mpv.conf`, scripts or in commandline that changes `--video-aspect-override` or `--video-params/aspect`, it will be affected.

You'll still be able to manually change the aspect ratio afterwards during playback. For example if you have a keybind set within `input.conf` to cycle through aspect ratio values like:

`CTRL+a cycle-values video-aspect-override "16:9" "16:10" "4:3" "2.35:1"`

The script doesn't change or alter configuration in other files, so removing the `boxtowide.lua` script from the mpv scripts folder is all that is needed to uninstall/disable.

# Preview/Demo
A screenshot of mpv running a 4:3 aspect ratio video that has been changed automatically to 16:9 aspect ratio on Windows 10.

![mpv-boxtowide preview](https://raw.githubusercontent.com/Samillion/mpv-boxtowide/master/mpv-boxtowide-demo.png)

# Can it be done with an even simpler script?
Yes, definitely. I've added checks that aren't really necessary. For example, the file extension check. I only wanted this script to run if the file being opened with mpv is a video file, so I added a file extension check in the initiation part of the script. To put it in layman's terms "If file is video, run script, otherwise, don't run script".

The other unnecessary step (kind of) I've taken is using `mp.unobserve_property(setBoxRatio)` once the aspect ratio check is done. There is no real need to use `mp.unobserve_property` here, however, I felt like it would be a waste of resources, if the property was being observed throughout video play even after the aspect ratio check and change are done.

The other and main reason I used `mp.unobserve_property(setBoxRatio)` is to allow manually changing the aspect ratio as I explained earlier. If it were kept active, every time you try to manually change it back to 4:3 aspect ratio, the script would trigger and change it to 16:9 instantly. I wanted the option to revert back to 4:3 aspect ratio remain available, not completely removed.
