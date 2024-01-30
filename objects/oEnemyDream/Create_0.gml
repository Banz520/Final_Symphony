/// @description Enemy Set Up
// Inherit the parent event
event_inherited();

function EnemyDreamStateTurn(){
		
	if(sprite_index != sprIdle)sprite_index = sprIdle;
	
	AnimateSprite();
		
	//Enemy AI here
	charaState = charaStateAttack;
}

function EnemyDreamStateAttack(){

	EnemyAttackHit(6,sHitEffectSlash,false);
}


//Declare Character States
charaStateTurn = EnemyDreamStateTurn;
charaStateAttack = EnemyDreamStateAttack;



charaState = charaStateWait;