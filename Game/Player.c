#include "Player.h"
#include "PlayerDefines.h"
#include "../System/InputDefines.h"
#include "../SystemLib/Include/Input.h"
#include "../SystemLib/Include/Sprites.h"

byte	playerX;		// Player X position
byte	currentFrame;	// Current frame
byte	frameDelay;		// Frame delay

void setupPlayer()
{
	playerX			= PlayerStartX;
	currentFrame	= 0;
	frameDelay		= AnimationDelay;

	selectSprite(127);
	selectSprite(PlayerSprite);
	setSpritePosition(playerX, PlayerStartY - ClawYOffset);
	setSpriteTileAndColor(PlaySpritePattern + 9, PlayerSpriteColor);

	selectSprite(PlayerSprite + 1);
	setSpritePosition(playerX, PlayerStartY);
	setSpriteTileAndColor(PlaySpritePattern + currentFrame, PlayerSpriteColor);

	selectSprite(PlayerSprite + 2);
	setSpritePosition(playerX, PlayerStartY);
	setSpriteTileAndColor(PlaySpritePattern + 1 + currentFrame, PlayerEyeColor);
}

void updatePlayer()
{
	byte	joy1	= readJoystick1();

	if ((joy1 & JoypadRight) != 0)
	{
		byte	allowedMove	= MaxPlayerRight - playerX;

		if (MoveSpeed >= allowedMove)
		{
			playerX	= MaxPlayerRight;

			resetAnimationFrame();
		}

		else
		{
			playerX	+= MoveSpeed;
			
			increaseAnimationFrame();
		}

		updatePlayerPosition();
	}

	else if ((joy1 & JoypadLeft) != 0)
	{
		if (playerX < MinPlayerLeft + MoveSpeed)
		{
			playerX	= MinPlayerLeft;

			resetAnimationFrame();
		}

		else
		{
			playerX	-= MoveSpeed;
			
			decreaseAnimationFrame();
		}

		updatePlayerPosition();
	}

	else
	{
		resetAnimationFrame();
	}
}

void updatePlayerPosition()
{
	selectSprite(PlayerSprite);
	setSpriteXPosition(playerX);

	selectSprite(PlayerSprite + 1);
	setSpriteXPosition(playerX);

	selectSprite(PlayerSprite + 2);
	setSpriteXPosition(playerX);
}

void updatePlayerTile()
{
	selectSprite(PlayerSprite + 1);
	setSpriteTile(PlaySpritePattern + (currentFrame << 1));
}

void increaseAnimationFrame()
{
	frameDelay--;

	if (0 == frameDelay)
	{
		currentFrame++;

		if (AnimationFrames == currentFrame)
		{
			currentFrame	= 0;
		}

		frameDelay	= AnimationDelay;

		updatePlayerTile();
	}
}

void decreaseAnimationFrame()
{
	frameDelay--;

	if (0 == frameDelay)
	{
		if (currentFrame > 0)
		{
			currentFrame--;
		}

		else
		{
			currentFrame	= AnimationFrames - 1;
		}

		frameDelay	= AnimationDelay;

		updatePlayerTile();
	}
}

void resetAnimationFrame()
{
	currentFrame	= 0;
	frameDelay		= AnimationDelay;

	updatePlayerTile();
}
