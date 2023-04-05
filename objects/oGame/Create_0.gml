/// @description Init Game & Variables & globals

global.combatState = COMBAT_STATE.WAIT;

global.gamePaused = false;
//global.clockCount = 0;

//Set Up Camera
global.iCamera = instance_create_layer(0,0,layer,oCamera);

//SetUp UI
surface_resize(application_surface,RES_WIDTH*2,RES_HEIGHT*2);

global.battleBackgroundSprite = sBackGroundBlack;
keyManualText = noone;
gamePausedText = noone;

RoomTransition(TRANS_TYPE.FADE,rStart);