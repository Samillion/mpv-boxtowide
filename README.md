# mpv-boxtowide
This script will check if the video file has a 4:3 aspect ratio (box) and if so, it will change it to 16:9 (wide).

Its intended purpose is for video files or libraries with old 4:3 aspect ratio content. Instead of having black bars on the sides or manually changing the aspect ratio every time, it will stretch it to 16:9 aspect ratio automatically.

**Note:**

This script changes `--video-aspect` to `-1` (default) to accurately check and change aspect ratio if needed. If you have something in `mpv.conf`, scripts or in commandline that changes `--video-aspect` or `--video-params/aspect`, it will be affected.

You'll still be able to manually change the aspect ratio afterwards during playback. For example if you have a keybind set within `input.conf` to cycle through aspect ratio values like:

`Ctrl+a cycle-values video-aspect "16:9" "4:3" "2.35:1" "-1"`

**Preview of a 4:3 video changed to 16:9**

![mpv-boxtowide preview](https://raw.githubusercontent.com/Samillion/mpv-boxtowide/master/mpv-boxtowide.png)