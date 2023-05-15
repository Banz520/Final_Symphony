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
	
	EnemyAttackThrow(6,PROYECTILE_SPR.FIREBALL)
}


//Declare Character States
charaStateTurn = EnemyStateTurn;
charaStateAttack = EnemyStateAttack;



charaState = charaStateWait;