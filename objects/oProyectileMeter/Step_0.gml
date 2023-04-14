	/// @description Get Input on shot 
if(!global.gamePaused){	
	var shotKey = keyboard_check_pressed(vk_space);
	if(shotKey){
		if(floor(image_index) > 7 && floor(image_index) < 11){
	
			//play sound
			parentChara.charaDamageMod = 1.5;	
		}
	
		image_speed = 0;
		parentChara.performAttack = true;
		instance_destroy();
	}


	if(floor(image_index)+1 == image_number)image_speed = -1;

	if(floor(image_index) == 0)image_speed = 1;
}
else image_speed = 0;