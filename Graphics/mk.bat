..\..\Tools\SCV\PNGToBackground Source\Background.png Background
IF ERRORLEVEL 1 goto errorOut

..\..\Tools\SCV\PNGToSprites Source\Sprites.png Sprites.spr
IF ERRORLEVEL 1 goto errorOut

..\..\Tools\BinToAsm Background.scn BackgroundScn.s
..\..\Tools\BinToAsm Background.spr BackgroundSpr.s
..\..\Tools\BinToAsm Sprites.spr SpritesSpr.s
..\..\Tools\BinToAsm Source/SemiGraphic.bin SemiGraphicScn.s

del *.scn
del *.spr

if exist *.obj del	*.obj
if exist *.lst del *.lst

exit /B 0

:errorOut
echo Build Error
