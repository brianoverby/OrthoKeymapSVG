# CreateKeymap.ps1

param (
     [Parameter(Mandatory,Position=0)]
     [ValidateSet(
        "ortho4x12_MIT",
        "ortho4x12_GRID",
        "ortho5x12_MIT",
        "ortho5x12_GRID",
        "ortho_CUSTOM",
        "split3x5_3xThumb",
        "split3x5_2xThumb",
        "split3x6_3xThumb",
        "split_CUSTOM")]
      [string]$Layout,
     [Parameter(Position=1)]
     [ValidateSet(1,2,3,4,5,6,7,8)]
      [int]$NumberOfKeyMaps = 1,
     [Parameter()] [int] $NumRows,
     [Parameter()] [int] $NumColumns,
     [Parameter()] [Switch]$MITLayout,
     [Parameter()] [int] $NumThumbKeysEachSide,
     [Parameter()] [Switch]$PrintTextTopLeft,
     [Parameter()] [Switch]$PrintTextTopRight,
     [Parameter()] [Switch]$PrintTextBottomLeft,
     [Parameter()] [Switch]$PrintTextBottomRight,
     [Parameter()] [Switch]$PrintTextCenter
 )


# For full Ortho boards (Planck etc.) this is the full row and column count
# For split keyboards this is row and column count for each half minus the thumb cluster
$keyCapRows = 0
$keyCapCols = 0
$splitLayout = $false
$thumbKeys = 0
$blankKeys = 0
$mit = $false

# Keycap specs
$keySpace = 3
$keyWidth = 40
$keyHeight = 40
$charOffset = 4
$keySplitSpace = 30


switch ($Layout) {
    "ortho4x12_MIT" { $splitLayout = $false; $keyCapRows = 4; $keyCapCols = 12; $mit = $true; $PrintTextCenter = $true; }
    "ortho4x12_GRID" { $splitLayout = $false; $keyCapRows = 4; $keyCapCols = 12; $mit = $false; $PrintTextCenter = $true; }
    "ortho5x12_MIT" { $splitLayout = $false; $keyCapRows = 5; $keyCapCols = 12; $mit = $true; $PrintTextCenter = $true; }
    "ortho5x12_GRID" { $splitLayout = $false; $keyCapRows = 5; $keyCapCols = 12; $mit = $false; $PrintTextCenter = $true; }
    "ortho_CUSTOM" { $splitLayout = $false; $keyCapRows = $NumRows; $keyCapCols = $NumColumns; $mit = $MITLayout }
    "split3x5_3xThumb" { $splitLayout = $true; $keyCapRows = 3; $keyCapCols = 5; $thumbKeys = 3; $PrintTextCenter = $true;}
    "split3x5_2xThumb" { $splitLayout = $true; $keyCapRows = 3; $keyCapCols = 5; $thumbKeys = 2; $PrintTextCenter = $true; }
    "split3x6_3xThumb" { $splitLayout = $true; $keyCapRows = 3; $keyCapCols = 6; $thumbKeys = 3; $PrintTextCenter = $true; }
    "split_CUSTOM" { $splitLayout = $true; $keyCapRows = $NumRows; $keyCapCols = $NumColumns; $thumbKeys = $NumThumbKeysEachSide }
    Default {}
}


# svg settings
$vbWitdh = $keyCapCols * ($keyWidth+$keySpace) + $keySpace
if($splitLayout) { $vbWitdh = ($vbWitdh * 2) + $keySplitSpace }
$vbHeight = $keyCapRows * ($keyHeight+$keySpace) + $keySpace


$svgOutput = @'
<?xml version="1.0" encoding="UTF-8" standalone="no"?>
<!DOCTYPE svg PUBLIC "-//W3C//DTD SVG 1.1//EN" "http://www.w3.org/Graphics/SVG/1.1/DTD/svg11.dtd">
'@

$svgOutput += "`n"+'<svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 ' + $vbWitdh + ' ' + $vbHeight+ '">' + "`n"
$svgOutput += @'
<style>
    svg {
        font-family: SFMono-Regular,Consolas,Liberation Mono,Menlo,monospace;
        font-kerning: normal;
        text-rendering: optimizeLegibility;
    }
    rect {
        fill: rgb(246, 248, 250);
    }
    rect.hold {
        fill: rgb(255, 205, 178);
    }
    text {
        font-size: 0.75em;
        stroke: none;
        fill: rgb(50,50,50);
    }
    .tl {
        text-anchor: start;
        dominant-baseline:hanging;
    }
    .tr {
        text-anchor: end;
        dominant-baseline:hanging;
    }
    .bl {
        text-anchor: start;
    }
    .br {
        text-anchor: end;
    }
    .cnt {
        text-anchor: middle;
        dominant-baseline:middle;
    }
    .layer {
        fill: rgb(190, 190, 190);
        font-size: 0.5em;
    }    
</style>
'@

if($splitLayout)
{
    if($thumbKeys -gt 0)
    {
        $keyCapRows += 1 # Thumb row is added
        $blankKeys = $keyCapCols-$thumbKeys
    }
    $keyCapCols *= 2 # Print both sides
}

# List for keycap svg
$keyCapList = @()


# Loop rows
for ($r = 0; $r -lt $keyCapRows; $r++)
{
    $y = ($keySpace + $keyHeight) * $r + $keySpace
    # Loop columns
    for ($c = 0; $c -lt $keyCapCols; $c++)
    {
        $x = ($keySpace + $keyWidth) * $c + $keySpace
        if($splitLayout)
        {
            if($c -ge ($keyCapCols/2)) { $x += $keySplitSpace }
        }
        $kWidth = $keyWidth
        if($r -eq ($keyCapRows-1))
        {
            # Ortho MIT
            if($mit)
            {
                if($c -eq ($keyCapCols/2)-1) { $kWidth = $keyWidth * 2 + $keySpace }
                if($c -eq ($keyCapCols/2)) { continue }
            }

            # Split, thumb row
            if($splitLayout)
            {
                if($c -lt $blankKeys -or $c -ge ($keyCapCols - $blankKeys)) { continue }
            }
        }

        $keyCapList += '<rect rx="4" x="' + $x + '" y="' + $y + '" width="' + $kWidth + '" height="' + $keyHeight + '" class=""/>'

        # Add text templates
        $xCnt = $x + ($kWidth/2)
        $yCnt = $y + ($keyHeight/2)

        $yTl = $y + $charOffset
        $xTl = $x + $charOffset

        $yTr = $yTl
        $xTr = $x + $kWidth - $charOffset

        $yBl = $y + $keyHeight - $charOffset
        $xBl = $xTl

        $yBr = $yBl
        $xBr = $xTr

        if($PrintTextCenter){
            $rnd = (97..122) | Get-Random | % {[char]$_}
            $keyCapList += '<text x="' + $xCnt + '" y="' + $yCnt + '" class="cnt">' + $rnd + '</text>'
        }
        if($PrintTextTopLeft){
            $rnd = (97..122) | Get-Random | % {[char]$_}
            $keyCapList += '<text x="' + $xTl + '" y="' + $yTl + '" class="layer tl">' + $rnd + '</text>'
        }
        if($PrintTextTopRight){
            $rnd = (97..122) | Get-Random | % {[char]$_}
            $keyCapList += '<text x="' + $xTr + '" y="' + $yTr + '" class="layer tr">' + $rnd + '</text>'
        }
        if($PrintTextBottomLeft){
            $rnd = (97..122) | Get-Random | % {[char]$_}
            $keyCapList += '<text x="' + $xBl + '" y="' + $yBl + '" class="layer bl">' + $rnd + '</text>'
        }
        if($PrintTextBottomRight){
            $rnd = (97..122) | Get-Random | % {[char]$_}
            $keyCapList += '<text x="' + $xBr + '" y="' + $yBr + '" class="layer br">' + $rnd + '</text>'
        }
    }
    if($r -lt ($keyCapRows-1)) { $keyCapList += "`n`n" }
}
$svgOutput
$keyCapList
"</svg>"