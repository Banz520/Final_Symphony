/// @description move to target
if(!global.gamePaused){
	
	
	if(!point_in_rectangle(x,y,0,0,RES_WIDTH,RES_HEIGHT)) instance_destroy();

	if(speed == 0){
		
		move_towards_point(
			target.x,
			targetCenterY,
			vel
		);
	}
	
	
	if(attackComesFromPlayer){
		if(collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,target,true,true)) && (keyboard_check_pressed(vk_space)){
			parentChara.CreateHitMarker(target,10,hitMarkSpr);
			instance_destroy();
		}
	}
	else{
		if(collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,target,true,true)){
			parentChara.CreateHitMarker(target,10,hitMarkSpr);
			instance_destroy();
		}
	}
}

else speed = 0;