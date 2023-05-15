/// @description Enemy Set Up
// Inherit the parent event
event_inherited();

function EnemyStateTurn(){
		
	sprite_index = sprIdle;
	AnimateSprite();
		
	//Enemy AI here
	charaState = charaStateAttack;
}

function EnemyStateAttack(){
	
	sprite_index = sprAttack;
	
	AnimateSprite();
	
	/*
	var playerCharaTarget = oBattleManager.playerCharasOnBattleList[|random_range(0,global.playerCharasOnBattle)];	
	if(floor(localFrame) == 6 && !instance_exists(oParabolicProyectile))CreateHitParabProyectile(playerCharaTarget,2,false,PROYECTILE_SPR.FIREBALL);
	
	hes fuckin asleep
	*/
	
	if(animationEnd)charaState = charaStateWait;
}


//Declare Character States
charaStateTurn = EnemyStateTurn;
charaStateAttack = EnemyStateAttack;



charaState = charaStateWait;