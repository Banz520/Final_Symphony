/// @description Enemy Set Up
// Inherit the parent event
event_inherited();

image_xscale = -1;

function EnemyStateTurn(){
		
	sprite_index = sprIdle;
	AnimateSprite();
		
	//Enemy AI here
	charaState = charaStateAttack;
}

function EnemyStateAttack(){

	EnemyAttackHit(6,sHitEffectSlash,false);
}


//Declare Character States
charaStateTurn = EnemyStateTurn;
charaStateAttack = EnemyStateAttack;



charaState = charaStateWait;