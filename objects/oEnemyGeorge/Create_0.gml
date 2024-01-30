/// @description Enemy Set Up
// Inherit the parent event
event_inherited();

georgeIsAwake = false;

sprHurt = sGeorgeHurt

turnThatAwoke = -1;
turnsToSleepAgain = 3;

function GeorgeStateHurt() {
	
	if(sprite_index != sprHurt){
		
		sprite_index = sprHurt;
		localFrame = 0;
			
		turnThatAwoke = oBattleManager.turnCount;
		georgeIsAwake = true
		
		sprIdle = sGeorgeIdle2;
	}
	
	//screen shake
	hitScreenShake = true;
	if(hitScreenShake)ScreenShake(1.5,2);
	hitScreenShake = false;
	
	//flash
	flash = 0.5;
	flashShader = shWhiteFlash;
	
	AnimateSprite(0.5);
	
	if(animationEnd) charaState = charaStateWait;
	
}

function GeorgeStateTurn(){
		
	sprite_index = sprIdle;
	AnimateSprite();
		
		
	//Enemy AI here
	
	var currentTurn = oBattleManager.turnCount
		
	if(georgeIsAwake){
		
		//sleep george if 3 turns have passed since he awoke
		if(currentTurn - turnThatAwoke >= turnsToSleepAgain){
			
			georgeIsAwake = false;
			turnThatAwoke = -1;
		}
		
		charaState = charaStateAttack;
	}
	else {
		
		//show_debug_message("404 wait");
		sprIdle = sGeorgeIdle;
		charaState = charaStateWait	
	}
}

function GeorgeStateAttack(){
	
	
	if(sprite_index != sprAttack) {
			
		sprite_index = sprAttack;	
		localFrame = 0;
	}
	
		
	if(floor(image_index) == 11 && !instance_exists(oLinearProyectile)){
			
		var playerCharaToShoot = oBattleManager.playerCharasOnBattleList[|global.playerCharasOnBattle - 1];
		CreateHitLinearProyectile(playerCharaToShoot,4,false,PROYECTILE_SPR.ARROW);
	}
		
	AnimateSprite();
		
	if(animationEnd){
		
		charaState = charaStateWait;
	}
}


//Declare Character States
charaStateTurn = GeorgeStateTurn;
charaStateAttack = GeorgeStateAttack;
charaStateHurt = GeorgeStateHurt;


charaState = charaStateWait;