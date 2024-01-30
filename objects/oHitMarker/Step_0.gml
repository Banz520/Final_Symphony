/// @description Check for input to negate damage
if(!global.gamePaused){
	
	var blockKey = global.keyContinue;
	//var totalDamage = damageFromParent;
	var defense = target.charaDefense - 1;
	
	AnimateSprite(dificultySpeed);

	if(animationEnd == false){
		
		if(blockKey){
	
			if(image_index < perfectFrame - 1){
				image_speed = 0;
			}
			else {
				image_speed = 0;
				defense += BUFFSMALL;
				
				//Give points for perfect block
				if(global.battlePoints < MAX_BATTLEPOINTS)global.battlePoints += global.battlePointsForPerfectAct;
			}
			
			HurtChara(defense, damageFromParent);
			
			instance_destroy();
		}
	}
	else{
		
		HurtChara(defense, damageFromParent);
			
		instance_destroy();
	}
}