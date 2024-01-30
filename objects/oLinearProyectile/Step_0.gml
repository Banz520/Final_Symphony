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
	
	//Hit the target with linear proyectile
	if(collision_rectangle(bbox_left,bbox_top,bbox_right,bbox_bottom,target,true,true)){
		
		parentChara.CreateHitMarker(target,vel,hitMarkSpr,parentChara);
		instance_destroy();
	}
	else {
	
		if(attackComesFromPlayer){
		
			// if projectile collides with other enemy instance, create hit marker
			if (!place_empty(x, y))
			{
			    for (var enemyInEnemyList = 0; enemyInEnemyList < global.enemiesOnBattle; enemyInEnemyList++)
			    {
			        var currentEnemyInList = oBattleManager.enemiesOnBattleList[|enemyInEnemyList];
				
			        // Check if the enemy is colliding and not in the hurt state
			        if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, currentEnemyInList, true, true) && (currentEnemyInList.charaState != currentEnemyInList.charaStateHurt))
			        {
					
			            // Check if a hit marker has already been created for this collision
			            if (!currentEnemyInList.hitMarkerCreated)
			            {
			                parentChara.CreateHitMarker(currentEnemyInList, vel, hitMarkSpr, parentChara, parentChara.charaDamageBase - 1);
				
			                // Set the hit marker flag to true
			                currentEnemyInList.hitMarkerCreated = true;
			            }
			        }
			        else
			        {
			            // Reset the hit marker flag if no collision occurs or the enemy is in the hurt state
			            currentEnemyInList.hitMarkerCreated = false;
				
			        }
			    }
			}

		}
		
		else {
			
			// if projectile collides with other playerchara instance, create hit marker
			if (!place_empty(x, y))
			{
			    for (var pCharaInPCharaList = 0; pCharaInPCharaList < global.playerCharasOnBattle; pCharaInPCharaList++)
			    {
			        var currentpCharaInList = oBattleManager.playerCharasOnBattleList[|pCharaInPCharaList];
				
			        // Check if the enemy is colliding and not in the hurt state
			        if (collision_rectangle(bbox_left, bbox_top, bbox_right, bbox_bottom, currentpCharaInList, true, true) && (currentpCharaInList.charaState != currentpCharaInList.charaStateHurt))
			        {
					
			            // Check if a hit marker has already been created for this collision
			            if (!currentpCharaInList.hitMarkerCreated)
			            {
			                parentChara.CreateHitMarker(currentpCharaInList, vel, hitMarkSpr, parentChara, parentChara.charaDamageBase - 1);
				
			                // Set the hit marker flag to true
			                currentpCharaInList.hitMarkerCreated = true;
			            }
			        }
			        else
			        {
			            // Reset the hit marker flag if no collision occurs or the enemy is in the hurt state
			            currentpCharaInList.hitMarkerCreated = false;
				
			        }
			    }
			}
			
		}
	}
}


else speed = 0;
