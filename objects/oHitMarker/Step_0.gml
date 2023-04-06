/// @description Check for input to negate damage
if(!global.gamePaused){
	var blockKey = keyboard_check_pressed(vk_space);

	AnimateSprite(dificultySpeed);

	if(animationEnd == false){
		if(blockKey){
	
			if(image_index < perfectFrame-1){
				image_speed = 0;
				defense = 0;
			}
			else {
				image_speed = 0;
				defense = target.charaDefense;
				if(global.battlePoints < 10)global.battlePoints++;
			}
			//esto lo deberia de cambiar
			totalDamage = (damage - damage*defense);
			target.charaHP -= totalDamage;
			CreateDamageNumber(target,totalDamage);
			target.charaState = target.charaStateHurt;
			
			instance_destroy();
		}
	}
	else{
		//esto lo deberia de cambiar
		defense = 0;
		totalDamage = (damage - damage*defense);
		target.charaHP -= totalDamage;
		CreateDamageNumber(target,totalDamage);
		target.charaState = target.charaStateHurt;
		
		instance_destroy();
	}
}