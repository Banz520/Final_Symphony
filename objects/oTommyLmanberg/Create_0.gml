/// @description Player Set Up

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

sprHurtListLength = array_length(sprHurt);


function PlayerStateWait(){
	
	sprite_index = sprIdle;
	AnimateSprite();
	keyConfirmPressedCount = 0;
	//choose(sprHurt,sprHurt2);
	//reset values
	hitScreenShake = true;
	currentSprHurt = sprHurt[(random_range(0,sprHurtListLength))];
		
}

function PlayerStateTurn(){
	
	sprite_index = sprIdle;
	AnimateSprite();
		
	DeployPlayerActionMenu();
		
	var keyConfirmAction = keyboard_check_pressed(vk_space);
	var keyCancelAction = keyboard_check_pressed(vk_tab);
	keyConfirmPressedCount += keyConfirmAction-keyCancelAction;
	if(keyConfirmPressedCount < 0)keyConfirmPressedCount = 0;
		
	switch(keyConfirmPressedCount){
		case 0:{
			buttonSelected = SelectButtonWithKeys(buttonActionList);
			break;
		}
		case 1: {
			if(buttonSelected == oButtonPlayerSpecial && global.battlePoints < charaSpecialActCost)keyConfirmPressedCount--;
			if(buttonSelected == oButtonPlayerAttack || buttonSelected == oButtonPlayerSpecial)enemyTarget = SelectEnemyWithKeys();
			else keyConfirmPressedCount++;
			break;
		}
		case 2: {
			if(buttonSelected == oButtonPlayerSpecial)global.battlePoints -= charaSpecialActCost;
			buttonSelected.executeAction = true;
			break;
		}
		default: break;
	}
	
}

function PlayerStateAttack(){
	
	DeletePlayerActionMenu();
	
	sprite_index = sprAttack;
	AnimateSprite();
	
	if(floor(localFrame) == 11 && !instance_exists(oLinearProyectile)) CreateHitLinearProyectile(enemyTarget,4,true,PROYECTILE_SPR.ARROW);
	if(animationEnd) charaState = charaStateWait;
		
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

function PlayerStateHurt(){
	
	sprite_index = currentSprHurt;
	AnimateSprite();
	
	//screen shake
	
	if(hitScreenShake) ScreenShake(2,4);	
	hitScreenShake = false;
	//flash
	flash = 0.5;
	flashShader = shWhiteFlash;
	
	//change state
	if(animationEnd){
		charaState = charaStateWait;
	}
	
}

function PlayerStateDead(){
	
	sprite_index = sprDead;
	AnimateSprite();
	if(animationEnd)instance_destroy();
	
}



//Declare Character States
charaStateWait = PlayerStateWait;
charaStateTurn = PlayerStateTurn;
charaStateAttack = PlayerStateAttack;
charaStateHurt = PlayerStateHurt;
charaStateDead = PlayerStateDead;
charaStateHeal = PlayerStateHeal;    
charaStateDefend = PlayerStateDefend;
charaStateSpecial = PlayerStateAttack;


buttonActionList = [oButtonPlayerAttack,oButtonPlayerDefend,oButtonPlayerSpecial];

charaState = charaStateWait;
global.combatState = COMBAT_STATE.PLAYER_TURN;

