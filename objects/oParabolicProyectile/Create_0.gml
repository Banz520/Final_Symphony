/// @description


var initHalfWayToTarget = point_distance(x,y,target.x,target.y);
var initAngleToTarget = point_direction(target.x,target.y,x,y);

initHalfWayToTargetX = target.x+(0.5*(initHalfWayToTarget*dcos(initAngleToTarget)));
initHalfWayToTargetY = target.y-target.sprite_height*1.5;

goingUp = true;
targetCenterY = target.y-target.sprite_height*0.5;

function ParabollicMovement(){
	
	if(speed > vel*1.5) speed = vel*1.5;
	if(speed <= 0)speed = 0.01;
	
	if(!point_in_rectangle(x,y,0,0,RES_WIDTH,RES_HEIGHT)) instance_destroy();

	if(!collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,target,false,true)){
	
		//shot above target
		if (goingUp) && (point_distance(x,y,initHalfWayToTargetX,initHalfWayToTargetY) > 10 ){
			
			// fast then slow down
			image_angle = point_direction(initHalfWayToTargetX,initHalfWayToTargetY,x,y);
			
			move_towards_point(
				initHalfWayToTargetX,
				initHalfWayToTargetY,
				vel * point_distance(x,y,initHalfWayToTargetX,initHalfWayToTargetY)*0.03
			);
			
		
			//parabola
			y -= (point_distance(x,y,initHalfWayToTargetX,initHalfWayToTargetY)*0.02);
			x -= 1/ point_distance(x,y,initHalfWayToTargetX,initHalfWayToTargetY)*0.03;
		
		}
	
		else{
			goingUp = false;
			image_angle = point_direction(target.x,target.y,x,y);
		
			
			//slow then fast
			move_towards_point(
				target.x,
				targetCenterY,
				vel/(point_distance(x,y,target.x,targetCenterY)*0.03)
			);
		
			if(point_distance(target.x,target.y,x,y) >= 24){
				//parabola
				y += 1/(point_distance(x,y,target.x,targetCenterY)*0.1);
				x -= point_distance(x,y,target.x,targetCenterY)*0.03;
			}
			
		
		}
		
	}
	else{
		speed = 0;
		x = target.x;
		y = target.y;
		
		parentChara.CreateHitMarker(target,0.4,sHitEffectStar);
		instance_destroy();
	}
	
	
	
}