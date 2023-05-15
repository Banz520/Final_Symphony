	/// @description Get Input on shot 
if(!global.gamePaused){
	if(global.combatState != COMBAT_STATE.PLAYER_ACT)instance_destroy();
	
	var shotKey = global.keyContinue;
	if(shotKey){
	
		var strength = image_index;
		if(strength >= 1) global.battlePoints += global.battlePointsForPerfectAct;
		//play sound
		parentChara.charaDamageMod += strength/10;	
	
		image_speed = 0;
		parentChara.performAttack = true;
		instance_destroy();
	}


	if(floor(image_index)+1 == image_number)image_speed = -1;

	if(floor(image_index) == 0)image_speed = 1;
}
else image_speed = 0;