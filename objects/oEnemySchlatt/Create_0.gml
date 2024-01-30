/// @description schlatt move set

// Inherit the parent event
event_inherited();

/*if there is more than one pchara schlatt should have a 
50 / 50 chance between making all enemies focus the weakest ally or 
mocking the strongest pchara to reduce their defense if theres only a pchara on stage schlatt
use his target pchara move but rather get drunk and heal himself
if an enemy dies , schlatt has a 60% chance of resurecting them
*/

linearProyectileSpawnOriginY = y - sprite_get_height(sprAttack) * 0.75;
linearProyectileSpawnOriginX = x - sprite_get_width(sprAttack) * 0.5;

function EnemySchlattTurn() {
	
	if(sprite_index != sprIdle) sprite_index = sprIdle;
	
	AnimateSprite();
	
	var act = choose(0,1,1,2,2);
	
	//show_debug_message(string(act));
	
	switch(act){
		
		case 0: {
			
			charaState = charaStateSpecial;
			break;
		}
		
		case 1: {
			
			charaState = charaStateAttack;	
			break;
		}
		
		
		case 2: {
			
			charaState = charaStateHeal;
			break;
		}
		
		default:{
			
			
			charaState = charaStateHurt;
			break;
		}
	}
	
}

function EnemySchlattHeal() {
	
	if (sprite_index != sprHeal){
		
		sprite_index = sprHeal;	
		localFrame = 0;
	}
	
	AnimateSprite();
	
	if(animationEnd){
		
		DrawBuffEfect();
		
		charaDamageMod += BUFFMID;
		charaBuffDuration = 2;
		
		image_speed = 0;
		
		CreateHitMarker(id,1,sHitEffectPoison,id,5);
		
		charaState = charaStateWait;
	}

}

function EnemySchlattAttack() {
	
	if(sprite_index != sprAttack) {
			
		sprite_index = sprAttack;	
		localFrame = 0;
	}
	
		
	if(floor(image_index) == 18 && !instance_exists(oLinearProyectile)){
			
		var playerCharaToShoot = oBattleManager.playerCharasOnBattleList[|0];
		CreateHitLinearProyectile(playerCharaToShoot,5,false,PROYECTILE_SPR.BULLET);
	}
		
	AnimateSprite();
		
	if(animationEnd){
			
		charaState = charaStateWait;
	}
}


function EnemySchlattSpecial() {
	
	if(sprite_index != sprSpecial){
		
		sprite_index = sprSpecial;
		
	}
	
	AnimateSprite();
	
	if(animationEnd) {
		
		
		for (var enemyToSetTauntInd = 0; enemyToSetTauntInd < global.enemiesOnBattle; enemyToSetTauntInd++){
		
			var enemyToSetTaunt = oBattleManager.enemiesOnBattleList[|enemyToSetTauntInd];
			
			if(enemyToSetTaunt == id)continue;
			
			var playerCharaToTarget = oBattleManager.playerCharasOnBattleList[|0];
		
			enemyToSetTaunt.enemyTauntTarget = playerCharaToTarget;
			enemyToSetTaunt.enemyTauntDuration = 2;
			enemyToSetTaunt.DrawAlertEffect();
		
		}
		
		charaState = charaStateWait;
	}
}

charaStateSpecial = EnemySchlattSpecial;
charaStateAttack = EnemySchlattAttack;
charaStateTurn = EnemySchlattTurn;
charaStateHeal = EnemySchlattHeal;

charaState = charaStateWait;