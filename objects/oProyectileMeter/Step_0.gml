	/// @description Get Input on shot 
if(!global.gamePaused){	
	if(global.combatState != COMBAT_STATE.PLAYER_ACT)instance_destroy();
	
	var shotKey = global.keyContinue;
	if(shotKey){
		if(floor(image_index) >= 7 && floor(image_index) <= 11){
			
			global.battlePoints += global.battlePointsForPerfectAct;
			//play sound
			parentChara.charaDamageMod += BUFFSMALL;	
		}
	
		image_speed = 0;
		parentChara.performAttack = true;
		instance_destroy();
	}


	if(floor(image_index) + 1 == image_number)image_speed = -1;

	if(floor(image_index) == 0)image_speed = 1;
}
else image_speed = 0;