## mpv-boxtowide
![Terminal](https://github.com/user-attachments/assets/aee0410e-1110-4f07-9405-e4578eff6ebf)

This script will check if the video file has a 4:3 aspect ratio (box) and if so, it will change it to 16:9 (wide).

Its intended purpose is for videos or libraries with old 4:3 aspect ratio content. Instead of manually changing the aspect ratio, it will stretch it to 16:9 aspect ratio automatically.

I like to keep my [mpv configuration](https://github.com/Samillion/mpv-conf) simple, that is why I created this script to match my simple use case.

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

## How to uninstall
The script doesn't write or alter configuration files, so removing the `boxtowide.lua` script from the mpv scripts folder is all that is needed to uninstall/disable.
