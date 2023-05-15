/// @description Init Game & Variables & globals

global.combatState = COMBAT_STATE.WAIT;
global.gameClock = 0;
global.gamePaused = false;
//global.clockCount = 0;

//Set Up Camera
global.iCamera = instance_create_layer(0,0,layer,oCamera);

//SetUp UI
surface_resize(application_surface,RES_WIDTH * UI_XSCALE,RES_HEIGHT * UI_YSCALE);

global.battleBackgroundSprite = sBackGroundBlack;
keyManualText = noone;
gamePausedText = noone;

keyContinue = ["SPACE",vk_space];
keyCancel = ["TAB",vk_tab];
keyNextUp = "W";
keyNextRight = "D";
keyPrevDown = "S";
keyPrevLeft = "A";

keyManual = string("Use {0}{1}{2}{3} to move through the menus/options\nUse {4} to confirm action/continue\nUse {5} to cancel action\nUse PAUSE to pause the game\nUse ESC when the game is paused to\nreturn to the level menu",keyNextUp,keyPrevLeft,keyPrevDown,keyNextRight,keyContinue[0],keyCancel[0]);

function ShowPauseDesc(currentRoomName){
	switch(currentRoomName){
		
			case "rBattle":{
						
				keyManualText = instance_create_depth(RES_WIDTH*0.4,16,depth,oTextBox,{
					description: keyManual,
					image_xscale: 1,
					xscaleRate: 1,
					imageHeight: RES_HEIGHT*0.275,
					showDesc: true,
					image_index: 0,
					font: fPixelTextMicro,
					textBoxWidth: RES_WIDTH*0.35
	
				});
		
				gamePausedText = instance_create_depth(RES_WIDTH*0.4,2,depth,oTextBox,{
					description: "GAME PAUSED",
					image_xscale: 1,
					xscaleRate: 1,
					imageHeight: RES_HEIGHT*0.275,
					showDesc: true,
					image_index: 0,
					font: fPixelTextMini,
					textBoxWidth: RES_WIDTH*0.35
	
				});
			
				show_debug_message("GAME PAUSED AT RBATTLE");
				
				
				break;
			}
		
			case "rLevelMenu":{
			
				keyManualText = instance_create_depth(RES_WIDTH-8,16,depth,oTextBox,{
						description: keyManual,
						image_xscale: 1,
						xscaleRate: 1,
						imageHeight: RES_HEIGHT*0.275,
						showDesc: true,
						image_index: 0,
						font: fPixelTextMicro,
						textBoxWidth: RES_WIDTH*0.35
					}
				);
			
				gamePausedText = instance_create_depth(RES_WIDTH-8,2,depth,oTextBox,{
					description: "GAME PAUSED",
					image_xscale: 1,
					xscaleRate: 1,
					imageHeight: RES_HEIGHT*0.275,
					showDesc: true,
					image_index: 0,
					font: fPixelTextMini,
					textBoxWidth: RES_WIDTH*0.35
	
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