/// @description Quackity Manberg Move set


// Inherit the parent event
event_inherited();

actionDone = false;

function QuackityManbergStateTurn() {
	
	if(sprite_index != sprIdle) {
			
		sprite_index = sprIdle;	
		localFrame = 0;
	}
	
	AnimateSprite();
	
	if(animationEnd){
		
		//since  all enemy turn are even numbers the % 3 will make this action perform every three enemy turns
		if((oBattleManager.turnCount % 3) == 0){
			
			charaState = charaStateSpecial;
		}
		else {
			charaState = charaStateAttack;
		}
	}
}


function QuackityManbergStateAttack(){
	
	
	if(sprite_index != sprAttack) {
			
		sprite_index = sprAttack;	
		localFrame = 0;
	}
	
		
	if(floor(image_index) == 15 && !instance_exists(oLinearProyectile)){
			
		var playerCharaToShoot = oBattleManager.playerCharasOnBattleList[|global.playerCharasOnBattle - 1];
		CreateHitLinearProyectile(playerCharaToShoot,4,false,PROYECTILE_SPR.ARROW);
	}
		
	AnimateSprite();
		
	if(animationEnd){
		
		charaState = charaStateWait;
	}
}


function QuackityManbergStateSpec() {
	
	if(sprite_index != sprSpecial) {
		actionDone = false;
		sprite_index = sprSpecial;	
		localFrame = 0;
	}
	
	if(floor(image_index) == 10 && actionDone == false){
		
		var quackityRandomAction = choose(0,1);
		
		if(quackityRandomAction == 1){
			
			//debuff playercharas
			for(var playerCharasToDeBuff = 0; playerCharasToDeBuff < global.playerCharasOnBattle; playerCharasToDeBuff++){
		
				var playerCharaToDeBuff = oBattleManager.playerCharasOnBattleList[|playerCharasToDeBuff];
		
				playerCharaToDeBuff.charaDamageMod -= BUFFMID;
				playerCharaToDeBuff.DrawDeBuffEfect();
			}	
		}
		
		if(quackityRandomAction == 0){
			
			// buff enemies
			for(var i = 0; i < global.enemiesOnBattle;i++){
			
				var enemyToBuff = oBattleManager.enemiesOnBattleList[|i];
				
				enemyToBuff.charaDamageMod += BUFFSMALL;
				enemyToBuff.charaBuffDuration = 2;
				enemyToBuff.DrawBuffEfect();
			
			}
		}
		
		actionDone = true;
	}
	
	AnimateSprite();
	
	if(animationEnd){
		
		charaState = charaStateWait;
	}
}

charaStateTurn = QuackityManbergStateTurn;
charaStateAttack = QuackityManbergStateAttack;
charaStateSpecial = QuackityManbergStateSpec;

charaState = charaStateWait;