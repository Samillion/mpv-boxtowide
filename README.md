# mpv-boxtowide
This script will check if the video file has a 4:3 aspect-ratio (box) and if so, it will change the aspect-ratio to 16:9 (wide).

Its intended purpose is for video files or libraries with old 4:3 content, could be home videos, TV shows or anything. Instead of having black bars on the sides or manually changing aspect-ratio every time a 4:3 video file plays, it will stretch it to 16:9 aspect-ratio automatically.

**Note:**

This script resets `--video-aspect` to `-1` (the default aspect-ratio of the video) to accurately check and change aspect-ratio if needed. If you have something in `mpv.conf` or in commandline that affects `--video-aspect`, it will be overwritten to `-1` (default).
