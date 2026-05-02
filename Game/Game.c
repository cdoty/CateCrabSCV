#include "Game.h"
#include "GraphicsData.h"
#include "Player.h"
#include "../System/VRAMDefines.h"
#include "../SystemLib/Include/Decompression.h"
#include "../SystemLib/Include/Graphics.h"
#include "../SystemLib/Include/Input.h"
#include "../SystemLib/Include/Sprites.h"
#include "../SystemLib/Include/System.h"

bool	exitGame;

void startGame()
{
	exitGame	= false;

	initRandSeed();
	clearJoysticks();
	clearSprites();

	setupGameSprites();

	// Transfer the top screen tiles, screen map, and sprites
	transferToVRAM(BackgroundScn, BGSpriteAttributes, BackgroundScnLength);
	transferToVRAM(BackgroundSpr, BGSpriteVRAM, BackgroundSprLength);

	// Transfer the semigraphic screen data
	transferToVRAM(SemiGraphicScn, ScreenVRAM, SemiGraphicScnLength);
	
	// Transfer the sprite patterns
	transferToVRAM(SpritesSpr, SpriteVRAM, SpritesSprLength);
	
	enableIRQ();
		
	while (!exitGame)
	{
		waitForVBlank();
		updateJoysticks();

		updateGame();
	}

	disableIRQ();
}

void updateGame()
{
	updatePlayer();
}

void setupGameSprites()
{
	setupPlayer();
}
