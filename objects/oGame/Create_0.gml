/// @description Init Game & Variables & globals

enum LANGUAGE {
	
	ENGLISH,
	SPANISH
	
}


gameLanguage = LANGUAGE.ENGLISH;

global.combatState = COMBAT_STATE.WAIT;
global.gameClock = 0;
global.gamePaused = false;


//Set Up Camera
global.iCamera = instance_create_layer(0,0,layer,oCamera);

//SetUp UI
surface_resize(application_surface,RES_WIDTH * UI_XSCALE,RES_HEIGHT * UI_YSCALE);

global.battleBackgroundSprite = sBackGroundBlack;

keyManualText = noone;
gamePausedText = noone;

//SetUp KeyBinds
keyContinue = ["Z",ord("Z")];
keyCancel = ["X",ord("X")];
keyOther = ord("C");
keyNextUp = vk_up;
keyNextRight = vk_right;
keyPrevDown = vk_down;
keyPrevLeft = vk_left;


keyManual = string("[ARROWS] - Move through the menus/options\n[{0} or SPACE] - Confirm action/Continue\n[{1} or SHIFT] - Cancel action\n[ESC] - pause the game",keyContinue[0],keyCancel[0]);

function ShowPauseDesc(currentRoomName){
	switch(currentRoomName){
		
			case "rBattle":{
						
				keyManualText = instance_create_depth(RES_WIDTH - 20 - RES_WIDTH * 0.35,16,depth,oTextBox,{
					description1: keyManual,
					hasSecondText: false,
					textColor1: c_white,
					image_xscale: 1,
					xscaleRate: 1,
					imageHeight: RES_HEIGHT * 0.275,
					showDesc: true,
					image_index: 0,
					font: fPixelTextMicro,
					textBoxWidth: RES_WIDTH*0.35
	
				});
		
				gamePausedText = instance_create_depth(RES_WIDTH - 20 - RES_WIDTH * 0.35,2,depth,oTextBox,{
					hasSecondText: false,
					textColor1: c_white,
					description1: "GAME PAUSED",
					image_xscale: 1,
					xscaleRate: 1,
					imageHeight: RES_HEIGHT * 0.275,
					showDesc: true,
					image_index: 0,
					font: fPixelTextMini,
					textBoxWidth: RES_WIDTH * 0.35
	
				});
			
				show_debug_message("GAME PAUSED AT RBATTLE");
				
				
				break;
			}
		
			case "rLevelMenu":{
			
				keyManualText = instance_create_depth(RES_WIDTH - 20 - RES_WIDTH * 0.35,16,depth,oTextBox,{
						description1: keyManual,
						hasSecondText: false,
						textColor1: c_white,
						image_xscale: 1,
						xscaleRate: 1,
						imageHeight: RES_HEIGHT * 0.275,
						showDesc: true,
						image_index: 0,
						font: fPixelTextMicro,
						textBoxWidth: RES_WIDTH * 0.35
					}
				);
			
				gamePausedText = instance_create_depth(RES_WIDTH - 20 - RES_WIDTH * 0.35,2,depth,oTextBox,{
					description1: "GAME PAUSED",
					hasSecondText: false,
					textColor1: c_white,
					image_xscale: 1,
					xscaleRate: 1,
					imageHeight: RES_HEIGHT * 0.275,
					showDesc: true,
					image_index: 0,
					font: fPixelTextMini,
					textBoxWidth: RES_WIDTH * 0.35
	
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
	
RoomTransition(TRANS_TYPE.FADE,rStart);