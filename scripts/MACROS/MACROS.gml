// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MACROS(){

	#macro FRAME_RATE 60

	#macro RES_WIDTH 320
	#macro RES_HEIGHT 180

	#macro UI_XSCALE 4
	#macro UI_YSCALE 4
	
	#macro TRANSITION_SPEED 0.01
	#macro OUT 0
	#macro IN 1
	
	#macro MAX_BATTLEPOINTS 20
	
	#macro BUFFBIG 3
	#macro BUFFMID 2
	#macro BUFFSMALL 1
	
	enum HP{
		
		HIGH = 50,
		MID = 42,
		LOW = 35
		
	}
	
	enum DMG{
		
		MASSIVE = 7,
		HIGH = 5,
		MID = 3,
		LOW = 2
		
	}
	
	enum COMBAT_STATE{
		
		PLAYER_TURN,
		PLAYER_ACT,
		ENEMY_TURN,
		ENEMY_ACT,
		WAIT,
		WIN,
		DEFEAT,
	
	}
	
	enum LEVELSELECT_SPRITE{
		
		WHITE_OUTLINE,
		LMANBERG_OUTLINE,
		RED_OUTLINE
	}
	
	enum PROYECTILE_SPR{
		FIREBALL,
		ARROW,
		POTION,
		ROCKET,
		BULLET,
		TNT
		
	}
		
		
}