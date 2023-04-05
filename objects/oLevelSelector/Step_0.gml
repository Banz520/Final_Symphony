/// @description Insert description here
// You can write your code in this editor

if(!global.gamePaused){
	if(selected){
	
		image_xscale = min(image_xscale+0.07,ogXScale + scaleXPercentage);
		image_yscale = min(image_yscale+0.15,ogYScale + scaleYPercentage);
	
		x = xPosScaled;
		y = yPosScaled;
	
		var gotoLevelKey = keyboard_check_pressed(vk_space) || keyboard_check_pressed(vk_enter);
	
		if(gotoLevelKey){
		
			global.battleEnemySpawnList = levelEnemyListCopy;
			global.battlePlayerCharaSpawnList = levelPlayerCharasListCopy;
			global.battleBackgroundSprite = levelBackgroundSprite;
			global.spawnDistance = levelSpawnDistance;

			RoomTransition(TRANS_TYPE.CURTAIN,rBattle);
		}
	
	}
	else{
		image_xscale = max(image_xscale-0.1,ogXScale);
		image_yscale = max(image_yscale-0.15,ogYScale);
	
		x = ogXPos;
		y = ogYPos;
	}
}

