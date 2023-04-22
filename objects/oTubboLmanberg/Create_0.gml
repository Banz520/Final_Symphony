/// @description Character States


// Inherit the parent event
event_inherited();

enemySelected = 0;
actionSelected = 0;

keyConfirmPressedCount = 0;

//GUI Set Up
healthBarXOffset = x-sprite_get_width(sHealthBar)*0.5;
healthBarYOffset = y+4;

damageNumberXOffset = x+6;
damageNumberYOffset = y-sprite_height;

buttonXOffset = x;
buttonYOffset = y-sprite_height*0.75;

//sprHurtListLength = array_length(sprHurt);


function PlayerStateWait(){
	
	sprite_index = sprIdle;
	AnimateSprite();
	keyConfirmPressedCount = 0;
	//choose(sprHurt,sprHurt2);
	//reset values
	hitScreenShake = true;
	//currentSprHurt = sprHurt[(random_range(0,sprHurtListLength))];
		
}


function PlayerStateAttack(){
	
	PlayerSplashAttack(enemyTarget,PROYECTILE_SPR.POTION,4,9,4);
		
}



function PlayerStateHeal(){
	
	DeletePlayerActionMenu();
	
	sprite_index = sprDefense;
	AnimateSprite();
	flash = 0.5;
	
	if(animationEnd){
		var prevHealth = charaHP;
		charaHP += charaRegen;
		var currentHealth = charaHP;
		healedcharaHP = currentHealth-prevHealth;
		if(charaHP > maxcharaHP)charaHP = maxcharaHP;
	
		//create number of damage done above the target
		instance_create_depth(
			damageNumberXOffset,
			damageNumberYOffset,
			depth,
			oHealNumber,
			{healTaken: healedcharaHP}
			);
			
		charaState = charaStateWait;
	}
}

function PlayerStateDefend(){
	DeletePlayerActionMenu();
	
	sprite_index = sprDefense;
	flash = 0.5;
	charaDefense = 0.5;
	charaState = charaStateWait;
}



//Declare Character States
charaStateWait = PlayerStateWait;
charaStateAttack = PlayerStateAttack;
charaStateHeal = PlayerStateHeal;    
charaStateDefend = PlayerStateDefend;
charaStateSpecial = PlayerStateAttack;


buttonActionList = [
	[oButtonPlayerAttack,"Attack all enemies dealing\n"+string(charaDamageBase)+" points of damage!\nCost: "+ string(charaAttackCost) + " Chaos Points"],
	[oButtonPlayerDefend,"Defend incoming attacks to save\nwasting chaos points"],
	[oButtonPlayerSpecial,"Heals partners health\nCost: "+ string(charaSpecialActCost) + " Chaos Points"]
];

buttonList = [-1];
for(var i = 0; i < array_length(buttonActionList); i++){
	buttonList[i] = buttonActionList[i][0];	
}
	

charaState = charaStateWait;
global.combatState = COMBAT_STATE.PLAYER_TURN;

