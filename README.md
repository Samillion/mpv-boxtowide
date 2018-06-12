# mpv-boxtowide
This script will check if the video file has a 4:3 aspect ratio (box) and if so, it will change it to 16:9 (wide).

Its intended purpose is for video files or libraries with old 4:3 aspect ratio content. Instead of having black bars on the sides or manually changing the aspect ratio every time, it will stretch it to 16:9 aspect ratio automatically.

Works well with a mixed aspect ratio playlist. It will only change the aspect ratio of 4:3 video files, leaving the rest to their default aspect ratio.

**Note:**

This script changes `--video-aspect` to `-1` (default) to accurately check and change aspect ratio if needed. If you have something in `mpv.conf`, scripts or in commandline that changes `--video-aspect` or `--video-params/aspect`, it will be affected.

You'll still be able to manually change the aspect ratio afterwards during playback. For example if you have a keybind set within `input.conf` to cycle through aspect ratio values like:

`Ctrl+a cycle-values video-aspect "16:9" "4:3" "2.35:1" "-1"`

**Preview of a 4:3 video changed to 16:9**

![mpv-boxtowide preview](https://raw.githubusercontent.com/Samillion/mpv-boxtowide/master/mpv-boxtowide.png)

**Can it be done with a simpler script?**

Yes, definitely. I've added checks that aren't really necessary. For example, the file extension check. I only wanted this script to run if the file being opened with mpv is a video file, so I added a file extension check in the initiation part of the script. To put it in layman's terms "If file is video, run script, otherwise, don't run script".

The other unnecessary step I've taken is using `mp.unobserve_property(setBoxRatio)` once the aspect ratio check is done. There is no real need to use `mp.unobserve_property` here, however, I felt like it would be a waste of resources, if the property was being observed throughout video play even after the aspect ratio check and change are done.
