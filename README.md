# OrthoKeymapSVG

A script to generate a keymap of you Planck/Preonic/Ortho/split ortho keyboard.
~~It's created in Python, so you'll need that on your system to run the script.~~
The new version is created in PowerShell so you'll need that on your system - see the following guide on [how to install PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell?view=powershell-7.2). The old Python version is not maintained any more, but still available [OldCreateOrthoKeymapSVG.py](OldCreateOrthoKeymapSVG.py).

- Download the script [CreateOrthoKeymapSVG.ps1](CreateOrthoKeymapSVG.ps1)
- Run the script and redirect output to a svg file:
  You need to specify a layout for your keymap with the `-Layout` parameter. You can use a predefined or a custom layout. Use tab completion to list all values.
  Create a Planck (4x12) MIT layout: `CreateOrthoKeymap.ps1 -Layout ortho4x12_MIT > myKeymap.svg`
  Create a split 3x5 with 6 thumb keys: `CreateOrthoKeymap.ps1 -Layout split3x5_3xThumb > myKeymap.svg`

- Edit the .svg file to match your layout - replace the random legends with you own (with a text editor of your choice)
- Open the .svg file in your browser and print it or convert it to png/jpg/whatever

## This is a sample layout matching my own Planck keymap

=======
![PlanckKeymap](PlanckKeymap.svg)

> > > > > > > d606150e460ae33ba5029d07f57bb94f3877528c
