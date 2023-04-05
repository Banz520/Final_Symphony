/// @description


targetCenterY = target.y-target.sprite_height*0.5;

image_angle = point_direction(target.x,targetCenterY,x,y);

move_towards_point(
	target.x,
	targetCenterY,
	vel
);

hitMarkSpr = ds_map_find_value(oBattleManager.hitMarkSprList,image_index);