/// @description Enemy Set Up
// Inherit the parent event
event_inherited();

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
	
	var playerCharaTarget = oBattleManager.playerCharasOnBattleList[|random_range(0,global.playerCharasOnBattle)];	
	if(floor(localFrame) == 6 && !instance_exists(oHitMarker))CreateHitMarker(playerCharaTarget,1,sHitEffectSlash);
	
	if(animationEnd)charaState = charaStateWait;
}

function EnemyStateHurt(){
	
	sprite_index = sprHurt;
	AnimateSprite();
	show_debug_message(localFrame);
	//screen shake
	
	hitScreenShake = true;
	if(hitScreenShake)ScreenShake(1,2);
	hitScreenShake = false;
	
	//flash
	flash = 0.5;
	flashShader = shWhiteFlash;
	
	show_debug_message(animationEnd);
	//change state
	if(animationEnd){
		charaState = charaStateWait;
		show_debug_message("trans from state hurt 2 state wait");
	}
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