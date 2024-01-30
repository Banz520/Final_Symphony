/// @description 

// Inherit the parent event
event_inherited();

sprSpecial = sEretLmanbrgSpecial;

function EnemyEretStateTurn(){
		
	if(sprite_index != sprIdle)sprite_index = sprIdle;
	
	AnimateSprite();
		
	//Enemy AI here
	//if there are more than 2 playercharas with buff defense eret will debuff them all 
	var playerCharasWithBuffDefense = 0;
	
	for(var playerCharasToCheck = 0; playerCharasToCheck < global.playerCharasOnBattle; playerCharasToCheck++){
		
		var playerCharaToCheck = oBattleManager.playerCharasOnBattleList[|playerCharasToCheck];
		
		if(playerCharaToCheck.charaDefenseMod >= 1) playerCharasWithBuffDefense++;
		
		if(playerCharasWithBuffDefense >= 2){
			
			charaState = charaStateSpecial;
			break;
		}
			
	}
	
	if(playerCharasWithBuffDefense < 2){
		
		charaState = charaStateAttack;
	}
}

function EnemyEretStateAttack(){

	EnemyAttackHit(14,sHitEffectSlash,false);
}

function EnemyEretStateSpecial() {
	
	
	if(sprite_index != sprSpecial){
		
		sprite_index = sprSpecial;
		localFrame = 0;
	}
	
	AnimateSprite();
	
	if(animationEnd){
		
		//debuff playercharas
		for(var playerCharasToDeBuff = 0; playerCharasToDeBuff < global.playerCharasOnBattle; playerCharasToDeBuff++){
		
			var playerCharaToDeBuff = oBattleManager.playerCharasOnBattleList[|playerCharasToDeBuff];
		
			playerCharaToDeBuff.charaDefenseMod -= BUFFMID;
			playerCharaToDeBuff.DrawDeBuffEfect();
		}
		
		charaState = charaStateWait;
	}
	
	
}

//Declare Character States
charaStateTurn = EnemyEretStateTurn;
charaStateAttack = EnemyEretStateAttack;
charaStateSpecial = EnemyEretStateSpecial;


charaState = charaStateWait;