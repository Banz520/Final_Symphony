// Script assets have changed for v2.3.0 see
// https://help.yoyogames.com/hc/en-us/articles/360005277377 for more information
function MACROS(){

	#macro FRAME_RATE 60

	#macro RES_WIDTH 320
	#macro RES_HEIGHT 180
	
	#macro TRANSITION_SPEED 0.02
	#macro OUT 0
	#macro IN 1
	
	enum COMBAT_STATE{
		
		PLAYER_TURN,
		PLAYER_ACT,
		ENEMY_TURN,
		ENEMY_ACT,
		WAIT,
		WIN,
		DEFEAT,
		HURT
		
	}
	
	enum LEVELSELECT_SPRITE{
		
		WHITE_OUTLINE,
		LMANBERG_OUTLINE,
		RED_OUTLINE
	}
	
	enum PROYECTILE_SPR{
		FIREBALL,
		ARROW
		
	}
		
		
}