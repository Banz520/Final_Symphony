/// @description Check for input to negate damage
if(!global.gamePaused){
	
	var blockKey = global.keyContinue;
	//var totalDamage = damageFromParent;
	
	if(!instance_exists(target)) instance_destroy();
	
	if(instance_exists(keyPressAlertOnTarget)){
		//show_debug_message(keyPressAlertOnTarget.image_index);
		
		if (keyPressAlertOnTarget.image_index > 2){
			
			keyPressAlertOnTarget.localFrame = 0;
		}
		
	}
	
	AnimateSprite(dificultySpeed + 1);

	if(blockKey){
		
		blockCounter++;
		
		if(instance_exists(keyPressAlertOnTarget)){
			keyPressAlertOnTarget.image_speed += 3;
		}
	}
	
	if(animationEnd){
		
		HurtChara(defense, damageFromParent);
		
	}

	if(blockCounter >= blockCounterLimit){
		instance_destroy(keyPressAlertOnTarget);
		instance_destroy();	
		
	}
	
}