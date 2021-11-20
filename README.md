# OrthoKeymapSVG

A script to generate a keymap for your Planck/Preonic/ortho/split ortho keyboard.
~~It's created in Python, so you'll need that on your system to run the script.~~
The new version is created in PowerShell so you'll need that on your system - see the following guide on [how to install PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.2). The old Python version is not maintained any more, but still available [OldCreateOrthoKeymapSVG.py](OldCreateOrthoKeymapSVG.py).

## Download the script

Download the script [CreateOrthoKeymapSVG.ps1](CreateOrthoKeymapSVG.ps1) to your computer. On windows you might need set execution policy to run the script (use `Set-ExecutionPolicy`).

## Supported layouts

You need to specify a layout when you run the script. The script has some predefined layouts and custom settings.

    -ortho4x12_MIT
    -ortho4x12_GRID
    -ortho5x12_MIT
    -ortho5x12_GRID
    -ortho_CUSTOM
    -split3x5_3xThumb
    -split3x5_2xThumb
    -split3x6_3xThumb
    -split_CUSTOM

`-Layout` is mandatory parameter but with the `*_CUSTOM` layouts you need to specify number of rows and columns with `-NumRows` and `-NumColumns` parameters. And with `split_CUSTOM` layout you also need to specify `-NumThumbKeysEachSide`.

NOTE: When specifying rows and columns on a split you just enter the numbers for one half.

## Text labels on keycaps

The default output prints random characters at the center of the keycaps. You can also add text to the four corners of the keycaps (see sample output). The random characters are just placeholders - so you need to edit the file to match your layout.

You can add the extra text labels by adding one or more of the `PrintText` parameters:

    -PrintTextTopLeft
    -PrintTextTopRight
    -PrintTextBottomLeft
    -PrintTextBottomRight
    -PrintTextCenter

## Misc

If you create a custom ortho layout you can select MIT layout (2u spacebar) with the parameter `-MITLayout`.  
There is defined a `hold` class in the css for the svg. It can be used to indicate a key beeing held down to activate a layer (see sample output).

## Edit to match your own keymap

After you created the keymap svg template you need to edit the svg file to match your own layout. You can also change the styles (font, colors, size, etc.)

## Sample output

### A Planck (4x12) MIT layout:

    CreateOrthoKeymapSVG.ps1 -Layout ortho4x12_MIT -PrintTextBottomRight -FileName keymap_ortho4x12.svg

![keymap_ortho4x12.svg](keymap_ortho4x12.svg)

### Create a split 3x5 with 6 thumb keys and 2 keymaps:

    CreateOrthoKeymapSVG.ps1 -Layout split3x5_3xThumb -NumberOfKeyMaps 2 -FileName keymap_split3x5.svg

![keymap_split3x5.svg](keymap_split3x5.svg)

### This is a sample layout matching my own Planck keymap after editing the svg file:

![PlanckKeymap](keymap_myPlanck.svg)
