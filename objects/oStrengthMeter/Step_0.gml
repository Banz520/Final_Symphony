	/// @description Get Input on shot 
if(!global.gamePaused){
	var shotKey = keyboard_check_pressed(vk_space);
	if(shotKey){
	
		var strength = image_index;
		//play sound
		parentChara.charaDamageMod = strength/10;	
	
		image_speed = 0;
		parentChara.performAttack = true;
		instance_destroy();
	}


	if(floor(image_index)+1 == image_number)image_speed = -1;

	if(floor(image_index) == 0)image_speed = 1;
}
else image_speed = 0;