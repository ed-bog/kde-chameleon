#!/bin/bash

# Set KDE wallpaper across all desktops
# taken from : https://github.com/RaitaroH/KDE-Terminal-Wallpaper-Changer

full_image_path=$(realpath "$1")

wallpaper_set_script="var allDesktops = desktops();
    print (allDesktops);
    for (i=0;i<allDesktops.length;i++)
    {
        d = allDesktops[i];
        d.wallpaperPlugin = 'org.kde.image';
        d.currentConfigGroup = Array('Wallpaper', 'org.kde.image', 'General');
        d.writeConfig('Image', 'file:///dev/null')
        d.writeConfig('Image', 'file://${full_image_path}')
    }"

qdbus org.kde.plasmashell /PlasmaShell org.kde.PlasmaShell.evaluateScript "${wallpaper_set_script}" 

# Generate + apply Color scheme with pywal 
# Make sure you edit your rc file to apply theme to new terminals : 
# https://github.com/dylanaraps/pywal/wiki/Getting-Started#applying-the-theme-to-new-terminals

wal -i $full_image_path 

walcache=$HOME/.cache/wal/colors.json

# Generate KDE color scheme from wal cache with the wallpaper we just set

# What to name color scheme, default to using filename of wallpaper
name=$(basename -- "$1")
name="${name%.*}"

background=$(jq '.special.background' $walcache -r)
foreground=$(jq '.special.foreground' $walcache -r)

color0=$(jq '.colors.color0' $walcache -r)
color1=$(jq '.colors.color1' $walcache -r)
color2=$(jq '.colors.color2' $walcache -r)
color3=$(jq '.colors.color3' $walcache -r)
color4=$(jq '.colors.color4' $walcache -r)
color5=$(jq '.colors.color5' $walcache -r)
color6=$(jq '.colors.color6' $walcache -r)
color7=$(jq '.colors.color7' $walcache -r)

# Generate .colors file with our color variables, save it in ~/.local/share/color-schemes 
echo "
[ColorEffects:Disabled]
Color=$background
ColorAmount=0
ColorEffect=3
ContrastAmount=0.55
ContrastEffect=1
IntensityAmount=-1
IntensityEffect=0

[ColorEffects:Inactive]
ChangeSelectionColor=true
Color=$background
ColorAmount=0
ColorEffect=0
ContrastAmount=0
ContrastEffect=0
Enable=false
IntensityAmount=-1
IntensityEffect=0

[Colors:Button]
BackgroundAlternate=$color0
BackgroundNormal=$background
DecorationFocus=$color3
DecorationHover=$color3
ForegroundActive=$color3
ForegroundInactive=$color0
ForegroundLink=$color3
ForegroundNegative=$color2
ForegroundNeutral=$color6
ForegroundNormal=$foreground
ForegroundPositive=$color5
ForegroundVisited=$color0

[Colors:Selection]
BackgroundAlternate=$color3
BackgroundNormal=$color3
DecorationFocus=$color3
DecorationHover=$color3
ForegroundActive=$background
ForegroundInactive=$color0
ForegroundLink=$color3
ForegroundNegative=$color2
ForegroundNeutral=$color6
ForegroundNormal=$foreground
ForegroundPositive=$color5
ForegroundVisited=$color0

[Colors:Tooltip]
BackgroundAlternate=$color0
BackgroundNormal=$background
DecorationFocus=$color3
DecorationHover=$color3
ForegroundActive=$color3
ForegroundInactive=$color0
ForegroundLink=$color3
ForegroundNegative=$color2
ForegroundNeutral=$color6
ForegroundNormal=$foreground
ForegroundPositive=$color5
ForegroundVisited=$color0

[Colors:View]
BackgroundAlternate=$color0
BackgroundNormal=$background
DecorationFocus=$color3
DecorationHover=$color3
ForegroundActive=$color3
ForegroundInactive=$color0
ForegroundLink=$color3
ForegroundNegative=$color2
ForegroundNeutral=$color6
ForegroundNormal=$foreground
ForegroundPositive=$color5
ForegroundVisited=$color0

[Colors:Window]
BackgroundAlternate=$color0
BackgroundNormal=$background
DecorationFocus=$color3
DecorationHover=$color3
ForegroundActive=$color3
ForegroundInactive=$color0
ForegroundLink=$color3
ForegroundNegative=$color2
ForegroundNeutral=$color6
ForegroundNormal=$foreground
ForegroundPositive=$color5
ForegroundVisited=$color0

[General]
ColorScheme=$name
Name=$name
shadeSortColumn=true

[KDE]
contrast=5

[WM]
activeBackground=$color3
activeBlend=$color3
activeForeground=$foreground
inactiveBackground=$color0
inactiveBlend=$color0
inactiveForeground=$color7" > ~/.local/share/color-schemes/$name.colors

# Apply the color scheme we just created
plasma-apply-colorscheme $name

# Run additional themeing scripts, pass variables if needed 
# exec ./other-scripts.sh $full_image_path

