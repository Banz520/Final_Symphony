/// @description 

// Inherit the parent event
event_inherited();

enemyTauntTarget = noone;
enemyTauntDuration = 0;

image_xscale = -1;

function EnemyChooseTargetMVP(highestPlayerCharaTargetVal = 0, playerCharaTargetSelected = noone){
	
	for(var i = 0; i < global.playerCharasOnBattle; i++){
			
		var currentPlayerCharaTarget = oBattleManager.playerCharasOnBattleList[|i];		
		var currentPlayerCharaTargetVal = currentPlayerCharaTarget.charaHP + currentPlayerCharaTarget.charaDamage;
		
		if(currentPlayerCharaTargetVal > highestPlayerCharaTargetVal){
			highestPlayerCharaTargetVal = currentPlayerCharaTargetVal;
			playerCharaTargetSelected = currentPlayerCharaTarget;
		}	
	}
	return playerCharaTargetSelected;
}

function EnemyChooseTargetLVP(lowestPlayerCharaTargetVal = 100, playerCharaTargetSelected = noone){
	
	for(var i = 0; i < global.playerCharasOnBattle; i++){
			
		var currentPlayerCharaTarget = oBattleManager.playerCharasOnBattleList[|i];		
		var currentPlayerCharaTargetVal = currentPlayerCharaTarget.charaHP + currentPlayerCharaTarget.charaDamage;
		
		if(currentPlayerCharaTargetVal < lowestPlayerCharaTargetVal){
			lowestPlayerCharaTargetVal = currentPlayerCharaTargetVal;
			playerCharaTargetSelected = currentPlayerCharaTarget;
		}	
	}
	return playerCharaTargetSelected;
}

function EnemyAttackHit(animLastFrame,hitMarkSpr,targetMVP = true){
	
	if(sprite_index != sprAttack){
		sprite_index = sprAttack;
		if(enemyTauntTarget == noone){
			if(targetMVP)playerCharaTarget = EnemyChooseTargetMVP();
			else playerCharaTarget = EnemyChooseTargetLVP()
		}
		else playerCharaTarget = enemyTauntTarget;
	}
	
	AnimateSprite();
	
	if(floor(localFrame) == animLastFrame && !instance_exists(oHitMarker))CreateHitMarker(playerCharaTarget,1,hitMarkSpr,id);
	
	if(animationEnd)charaState = charaStateWait;
}

function EnemyAttackThrow(animLastFrame,proyectileSpr){
	
	if(sprite_index != sprAttack){
		sprite_index = sprAttack;
		
	}
	
	AnimateSprite();
	
	var playerCharaTarget = oBattleManager.playerCharasOnBattleList[|0];	
	
	if(floor(localFrame) == animLastFrame && !instance_exists(oParabolicProyectile))CreateHitParabProyectile(playerCharaTarget,2,false,proyectileSpr);
	
	if(animationEnd)charaState = charaStateWait;
}

function EnemyStateWait(){
		
	sprite_index = sprIdle;
	AnimateSprite();
}

charaStateWait = EnemyStateWait;
