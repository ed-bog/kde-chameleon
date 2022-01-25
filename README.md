<div align="center">

# 🦎 KDE Chameleon 🦎

#### Automatically generate KDE color schemes based on your wallpaper
  
![Collage](https://i.imgur.com/LaTxnTk.jpg)
 
  
</div>

## Requirements 

### [Pywal](https://github.com/dylanaraps/pywal)

#### System-wide install (sudo)

  `pip3 install pywal`

### A KDE Theme that follows your color scheme 
This is required to get the colors in all your kde applications 

The theme i used is : [arch](https://store.kde.org/p/1540630)

## Installation 
Simply copy or clone the script, and make it executable.

## Usage 
The script requires only 1 argument : the picture you want to set as wallpaper

`./kde-chameleon.sh wallpaper.png`

This will set that picture as a wallpaper across all desktops, genereate a .colors file in `~/.local/share/color-schemes/` using the pywal cache, and apply that color scheme.

### Making the terminal theme permanent
By default pywal only applies the color scheme to the current terminal.

To make it permanent accross all new terminal windows too, check out : 

https://github.com/dylanaraps/pywal/wiki/Getting-Started#applying-the-theme-to-new-terminals 

### Adding additional theming scripts 
This script only generates and applies a KDE color scheme, which is active in all KDE applications (settings/dolphin/dialog windows/...) + your terminal.

If you want to theme additional applications like spotify/discord/firefox/... 
you can easily plug in other scripts that automatically do that for you too based on this color scheme.

At the end of the script theres a call to execute `other_scripts.sh` where you can add your own scripts based on your needs.

There are already alot of scripts availible to theme different applications using pywal, check out : 

https://github.com/dylanaraps/pywal/wiki/Customization

The script i used to theme my firefox is [pywalfox](https://github.com/Frewacom/pywalfox) ! It's very awesome.







