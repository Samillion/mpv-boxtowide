## mpv-boxtowide
![Terminal](https://github.com/user-attachments/assets/aee0410e-1110-4f07-9405-e4578eff6ebf)

This script detects if a video has a 4:3 aspect ratio and automatically adjusts it to 16:9 (wide).

It is designed for libraries with older 4:3 content, stretching them to 16:9 without manual intervention. The script aligns with my preference for a simple [mpv configuration](https://github.com/Samillion/mpv-conf) to fit this straightforward use case.

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
