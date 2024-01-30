/// @description Pause Code
// You can write your code in this editor

//show_debug_message(global.gameClock);
global.gameClock += delta_time / 200000;
if(global.gameClock > 30)global.gameClock = 0;

var pauseKey = keyboard_check_pressed(vk_escape);
var returnToLevelMenuKey = keyboard_check_pressed(vk_tab);

//Get Key Input
global.keyContinue =  keyboard_check_pressed(keyContinue[1]) || keyboard_check_pressed(vk_space);
global.keyOther = keyboard_check_pressed(keyOther);
global.keyCancel = keyboard_check_pressed(keyCancel[1]) || keyboard_check_pressed(vk_shift);
global.keyNextUp = keyboard_check_pressed(keyNextUp);
global.keyPrevDown = keyboard_check_pressed(keyPrevDown);
global.keyNextRight = keyboard_check_pressed(keyNextRight);
global.keyPrevLeft = keyboard_check_pressed(keyPrevLeft);

var currentRoom = string(room_get_name(room));

if(pauseKey){
	
	global.gamePaused = !global.gamePaused;

	if(global.gamePaused){
		
		//keyManual = string("*Use {0}{1}{2}{3} to move through the menus/options\n*Use {4} to confirm action/continue\n*Use {5} to cancel action\n*Use PAUSE to pause the game\n*Use ESC when the game is paused\nto return to the level menu",keyNextUp,keyPrevLeft,keyPrevDown,keyNextRight,keyContinue[0],keyCancel[0]);
	
		ShowPauseDesc(currentRoom);
	}
	else{
	
		if(instance_exists(gamePausedText) && instance_exists(keyManualText)){
			instance_destroy(gamePausedText);
			instance_destroy(keyManualText);
		
		}
	}
}
	
if(global.gamePaused)&&(currentRoom == "rBattle")&&(returnToLevelMenuKey){
	global.gamePaused = !global.gamePaused;
	RoomTransition(TRANS_TYPE.CURTAIN,rLevelMenu);	
}
