/// @description Check for input to negate damage
if(!global.gamePaused){
	var blockKey = global.keyContinue;
	var totalDamage = parentChara.charaDamage;
	var defense = target.charaDefense-1;
	
	AnimateSprite(dificultySpeed);

	if(animationEnd == false){
		if(blockKey){
	
			if(image_index < perfectFrame-1){
				image_speed = 0;
			}
			else {
				image_speed = 0;
				defense += BUFFMID;
				if(global.battlePoints < MAX_BATTLEPOINTS)global.battlePoints += global.battlePointsForPerfectAct;
			}
			
			//Hurt Chara
			totalDamage -= parentChara.charaDamage*defense;
			totalDamage = max(1,ceil(totalDamage));
			target.charaHP -= totalDamage;
			CreateDamageNumber(target,totalDamage);
			target.charaState = target.charaStateHurt;
			
			instance_destroy();
		}
	}
	else{
		
		//Hurt Chara
		totalDamage -= parentChara.charaDamage*defense;
		totalDamage = max(1,ceil(totalDamage));
		target.charaHP -= totalDamage;
		CreateDamageNumber(target,totalDamage);
		target.charaState = target.charaStateHurt;
		
		instance_destroy();
	}
}