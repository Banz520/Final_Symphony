/// @description Enemy Set Up
// Inherit the parent event
event_inherited();

image_xscale = -1;

//GUI Set Up
healthBarXOffset = x-sprite_get_width(sHealthBar)*0.5;
healthBarYOffset = y+4;

damageNumberXOffset = x+6;
damageNumberYOffset = y-sprite_height;




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


//Declare Character States
charaStateTurn = EnemyStateTurn;
charaStateAttack = EnemyStateAttack;



charaState = charaStateWait;