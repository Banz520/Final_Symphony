/// @description Pause Code
// You can write your code in this editor
var pauseKey = keyboard_check_pressed(vk_pause);
var returnToLevelMenuKey = keyboard_check_pressed(vk_escape);
var currentRoomName = string(room_get_name(room));
if(pauseKey){
	
	global.gamePaused = !global.gamePaused;

	if(global.gamePaused){
		
		var keyManual = "Use WASD to move through the menus/options\nUse SPACE to confirm action/continue\nUse TAB to cancel action\nUse PAUSE to pause the game\nUse ESC when the game is paused\nto return to the level menu";
	
		show_debug_message(string(currentRoomName));
		switch(currentRoomName){
		
			case "rBattle":{
						
				keyManualText = instance_create_depth(RES_WIDTH*0.35,16,depth,oTextBox,{
					description: keyManual,
					image_xscale: 1,
					xscaleRate: 1,
					imageHeight: RES_HEIGHT*0.25,
					showDesc: true,
					image_index: 0,
					font: fPixelTextMicro,
					textBoxWidth: RES_WIDTH*0.3
	
				});
		
				gamePausedText = instance_create_depth(RES_WIDTH*0.35,2,depth,oTextBox,{
					description: "GAME PAUSED",
					image_xscale: 1,
					xscaleRate: 1,
					imageHeight: RES_HEIGHT*0.25,
					showDesc: true,
					image_index: 0,
					font: fPixelTextMini,
					textBoxWidth: RES_WIDTH*0.3
	
				});
			
				show_debug_message("GAME PAUSED AT RBATTLE");
				
				
				break;
			}
		
			case "rLevelMenu":{
			
				keyManualText = instance_create_depth(RES_WIDTH-8,16,depth,oTextBox,{
						description: keyManual,
						image_xscale: 1,
						xscaleRate: 1,
						imageHeight: RES_HEIGHT*0.25,
						showDesc: true,
						image_index: 0,
						font: fPixelTextMicro,
						textBoxWidth: RES_WIDTH*0.3
					}
				);
			
				gamePausedText = instance_create_depth(RES_WIDTH-8,2,depth,oTextBox,{
					description: "GAME PAUSED",
					image_xscale: 1,
					xscaleRate: 1,
					imageHeight: RES_HEIGHT*0.25,
					showDesc: true,
					image_index: 0,
					font: fPixelTextMini,
					textBoxWidth: RES_WIDTH*0.3
	
				});
			
				break;
				show_debug_message("GAME PAUSED AT RLEVELMENU");
			}
		
			default:{
				show_debug_message("GAME PAUSED AT UNKNOWN ROOM"); 
			
				global.gamePaused = !global.gamePaused;
				break;
			
			}
		}
	
	}
	else{
	
		if(instance_exists(gamePausedText) && instance_exists(keyManualText)){
			instance_destroy(gamePausedText);
			instance_destroy(keyManualText);
		
		}
	}
}
	
if(global.gamePaused)&&(currentRoomName == "rBattle")&&(returnToLevelMenuKey){
	global.gamePaused = !global.gamePaused;
	RoomTransition(TRANS_TYPE.CURTAIN,rLevelMenu);	
}
