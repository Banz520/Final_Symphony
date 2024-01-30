/// @description 

// Inherit the parent event
event_inherited();

enemyTauntTarget = noone;
enemyTauntDuration = 0;
playerCharaTarget  = noone;

image_xscale = -1;

function EnemyAttackHit(animLastFrame,hitMarkSpr,targetMVP = true){
	
	if(sprite_index != sprAttack){
		sprite_index = sprAttack;
		if(enemyTauntTarget == noone){
			if(targetMVP)playerCharaTarget = FindMVPChara(global.playerCharasOnBattle, oBattleManager.playerCharasOnBattleList);
			else playerCharaTarget = FindLVPChara(global.playerCharasOnBattle, oBattleManager.playerCharasOnBattleList);
		}
		else playerCharaTarget = enemyTauntTarget;
		show_debug_message(playerCharaTarget);
	}
	
	AnimateSprite();
	
	if(floor(localFrame) == animLastFrame && !instance_exists(oHitMarker)){
		CreateHitMarker(playerCharaTarget,1,hitMarkSpr,id);
	}
	
	if(animationEnd){
		charaState = charaStateWait;
		playerCharaTarget = noone;
	}
}

function EnemyAttackThrow(animLastFrame,proyectileSpr){
	
	if(sprite_index != sprAttack){
		sprite_index = sprAttack;
		
	}
	
	AnimateSprite();
	
	playerCharaTarget = oBattleManager.playerCharasOnBattleList[|0];	
	
	if(floor(localFrame) == animLastFrame && !instance_exists(oParabolicProyectile))CreateHitParabProyectile(playerCharaTarget,2,false,proyectileSpr);
	//playerCharaTarget = noone;
	if(animationEnd)charaState = charaStateWait;
}


function EnemyAttackThrowSpam(animLastFrame,proyectileSpr){
	
	if(sprite_index != sprAttack){
		sprite_index = sprAttack;
		
	}
	
	AnimateSprite();
	
	playerCharaTarget = oBattleManager.playerCharasOnBattleList[|0];	
	
	if(floor(localFrame) == animLastFrame && !instance_exists(oParabolicProyectile)){
		CreateHitParabProyectile(playerCharaTarget,2,false,proyectileSpr,true);
		
	}
	
	//playerCharaTarget = noone;
	
	if(animationEnd)charaState = charaStateWait;
}

function EnemyStateWait(){
		
	sprite_index = sprIdle;
	AnimateSprite();
}

charaStateWait = EnemyStateWait;
