/// @description Enemy Set Up
// Inherit the parent event
event_inherited();

//remove
sprIdle = sWilburIdle;

image_xscale = -1;

//GUI Set Up
healthBarXOffset = x-sprite_get_width(sHealthBar)*0.5;
healthBarYOffset = y+4;

damageNumberXOffset = x+6;
damageNumberYOffset = y-sprite_height;



function EnemyStateWait(){
		
	sprite_index = sprIdle;
	AnimateSprite();
}

function EnemyStateTurn(){
		
	sprite_index = sprIdle;
	AnimateSprite();
		
	//Enemy AI here
	charaState = charaStateAttack;
}

function EnemyStateAttack(){
	
	sprite_index = sprAttack;
	
	AnimateSprite();
	if(animationEnd){
		
		hitAction = choose(1,1,2);
		
		var playerCharaTarget = oBattleManager.playerCharasOnBattleList[|random_range(0,global.playerCharasOnBattle)];
		
		switch(hitAction){
			
			case 0:{
				CreateHitMarker(playerCharaTarget,0,sHitEffectStar);
				break;
			}
			
			case 1:{
				CreateHitProyectile(playerCharaTarget,1.5);
				break;
			}
			
			case 2:{
				
				CreateHitLinearProyectile(playerCharaTarget,3,false);
				break;
			}
			
		}
			
		charaState = charaStateWait;
	
	}// if attack animation ended
	
}

function EnemyStateHurt(){
	
	sprite_index = sprHurt;
	AnimateSprite();
	//screen shake
	hitScreenShake = true;
	if(hitScreenShake)ScreenShake(1,2);
	hitScreenShake = false;
	//flash
	flash = 0.5;
	flashShader = shWhiteFlash;
	//change state
	if(animationEnd)charaState = charaStateWait;
}

function EnemyStateDead(){
	
	sprite_index = sprDead;
	AnimateSprite();
	if(animationEnd)instance_destroy();
	
}


//Declare Character States
charaStateWait = EnemyStateWait;
charaStateTurn = EnemyStateTurn;
charaStateAttack = EnemyStateAttack;
charaStateHurt = EnemyStateHurt;
charaStateDead = EnemyStateDead;


charaState = charaStateWait;