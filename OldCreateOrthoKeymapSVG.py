#!/usr/bin/python
import random

# =============================================
# Create ortho keymap - full grid or MIT layout
# =============================================


###############################################
# ---------------- EDIT HERE ---------------- #
###############################################
# Define keyboard (Edit to match your layout)
keyCapRows = 4
keyCapCols = 12
mit = True # Using MIT layout?
randomFillChar = True # Fills you keymap with random uppercase chars - set to False if you like to use fillChar instead 
fillChar = 'X' # Use this fill char if randomFillChar is False (can be empty string)


###############################################
# "Keycap specs" (No need to edit here)
space = 5 
width = 40
height = 40
charOffset = 4

###############################################
# Layers 
centerLayer = list()
toprightLayer = list()
bottomrightLayer = list()
bottomleftLayer = list()
topleftLayer = list()

###############################################
# ---------------- EDIT HERE ---------------- #
###############################################
# Layers to print - remove the ones you don't need from the list
printLayers = [centerLayer,toprightLayer,bottomrightLayer,bottomleftLayer,topleftLayer]


###############################################
# Def. + stylesheet - you can edit the styles if you like, this is just to get started

vbWidth = keyCapCols * (width+space) + space # Viewbox width 
vbHeight = keyCapRows * (height+space) + space # Viewbox height
svgStart = '''<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
'''
svgStart += '<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ' + str(vbWidth) + ' ' + str(vbHeight)+ '">'

# Edit from here if you need another style
svgStyle = '''<style>
    svg { fill: none; stroke: rgb(211, 211, 211); font-size: 0.5rem; font-weight: 300;}

    .tl { font-size: 1.0em; fill: rgb(211, 211, 211); text-anchor: start; dominant-baseline:hanging;}
    .tr { font-size: 1.0em; fill: rgb(251, 133, 0); text-anchor: end; dominant-baseline:hanging;}

    .bl { font-size: 1.0em; fill: rgb(72, 149, 239); text-anchor: start;}
    .br { font-size: 1.0em; fill: rgb(87, 204, 153); text-anchor: end;}
    .cnt { font-size: 1.0em; fill: rgb(22, 26, 29); text-anchor: middle; dominant-baseline:middle;}

    text { font-family: Courier New; stroke: none}
    rect { stroke-width: 0.5;}

    rect.lw { fill: rgb(72, 149, 239); stroke: rgb(72, 149, 239);}
    text.lw { fill: rgb(250, 250, 250);}
    rect.rs { fill: rgb(251, 133, 0); stroke: rgb(251, 133, 0);}
    text.rs { fill: rgb(250, 250, 250);} 
     
</style>'''


###############################################
# Create the keycaps
keycaps = list()
for r in range(keyCapRows):
    y = (space + height) * r + space
    for c in range(keyCapCols):
        x = (space + width) * c + space
        kwidth = width
        if mit and r == (keyCapRows - 1): # Using MIT, skip a key and create a "space" key
            if c == ((keyCapCols // 2) - 1):
                kwidth = width * 2 + space
            if c == (keyCapCols // 2):
                continue

        if c == 0:
            keycaps.append('\n# Keycaps - row: ' + str(r+1))
            centerLayer.append('\n# Center layer - row: '+ str(r+1))
            toprightLayer.append('\n# Top right layer - row: '+ str(r+1))
            topleftLayer.append('\n# Top left layer - row: '+ str(r+1))
            bottomrightLayer.append('\n# Bottom right layer - row: '+ str(r+1))
            bottomleftLayer.append('\n# Bottom left layer - row: '+ str(r+1))
        
        # Add keycap
        keycaps.append('<rect rx="3" x="' + str(x) + '" y="' + str(y) + '" width="' + str(kwidth) + '" height="' + str(height) + '"/>')

        # Add layers
        # x/y coordinates for layers
        yTl = y + charOffset
        yTr = yTl
        yBl = y + height - charOffset
        yBr = yBl

        xTl = x + charOffset
        xBl = xTl
        xTr = x + kwidth - charOffset
        xBr = xTr

        xCnt = x + (kwidth/2)
        yCnt = y + (height/2)

        gridClass = 'r'+ str(r+1) + ' c' + str(c+1) 

        if randomFillChar: fillChar = chr(random.randint(ord('A'), ord('Z'))) # Adding random fill char
        centerLayer.append('<text x="'+ str(xCnt) +'" y="'+ str(yCnt) +'" class="cnt '+ gridClass+'">'+ fillChar +'</text>')
        if randomFillChar: fillChar = chr(random.randint(ord('A'), ord('Z'))) # Adding random fill char
        toprightLayer.append('<text x="'+ str(xTr) +'" y="'+ str(yTr) +'" class="tr '+ gridClass+'">'+ fillChar +'</text>')
        if randomFillChar: fillChar = chr(random.randint(ord('A'), ord('Z'))) # Adding random fill char
        bottomleftLayer.append('<text x="'+ str(xBl) +'" y="'+ str(yBl) +'" class="bl '+ gridClass+'">'+ fillChar +'</text>')
        if randomFillChar: fillChar = chr(random.randint(ord('A'), ord('Z'))) # Adding random fill char
        topleftLayer.append('<text x="'+ str(xTl) +'" y="'+ str(yTl) +'" class="tl '+ gridClass+'">'+ fillChar +'</text>')
        if randomFillChar: fillChar = chr(random.randint(ord('A'), ord('Z'))) # Adding random fill char
        bottomrightLayer.append('<text x="'+ str(xBr) +'" y="'+ str(yBr) +'" class="br '+ gridClass+'">'+ fillChar +'</text>')
        
###############################################
# Print SVG definitions + stylesheet
print(svgStart)
print(svgStyle)


###############################################
# Print keycaps
for line in keycaps:
    print(line)

###############################################
# Print layers 
for layer in printLayers:
    for key in layer:
        print(key)

###############################################
# Print the end tag
print('\n</svg>')