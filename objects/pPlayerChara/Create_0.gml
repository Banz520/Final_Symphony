//@desc Basic Chara functs
event_inherited();

buttonXOffset = x;
buttonYOffset = y-sprite_height*0.75;

enemySelected = 0;
actionSelected = 0;

keyConfirmPressedCount = 0;
buttonSelected = 0;

performAttack = false;

playerChooseTargetToAtk = true;
playerChooseTargetToHeal = true;
playerChooseTargetToSpecial = true;

buttonActionList = [-1];

function SetButtonList(){
	
	buttonList = [-1];
	for(var i = 0; i < array_length(buttonActionList); i++){
		buttonList[i] = buttonActionList[i][0];	
	}
	
}

function SelectEnemyWithKeys(){
	
	//Select enemy to interact with
	var keySelectLeft = (global.keyPrevLeft || global.keyNextUp)*-1;
	var keySelectRight = (global.keyNextRight|| global.keyPrevDown);
			
	//keep selection on the enemy list number range
	if(enemySelected <= (global.enemiesOnBattle-1) && enemySelected >= 0){
		enemySelected += keySelectLeft+keySelectRight;
		
		if(enemySelected > (global.enemiesOnBattle-1)){
			enemySelected = 0;
		}
		else if(enemySelected < 0){
			enemySelected = (global.enemiesOnBattle-1);
		}
	}
	else{
		if(enemySelected > (global.enemiesOnBattle-1)){
			enemySelected = 0;
		}
		else if(enemySelected < 0){
			enemySelected = (global.enemiesOnBattle-1);
		}
	}//keep selection on the enemy list number range
				
	enemyTarget = oBattleManager.enemiesOnBattleList[|enemySelected];	
	enemyTarget.flash = 0.5;
	return enemyTarget;
}
	
function DeployPlayerActionMenu(){
	
	//Spawn Button Actions
	spawnAngle = -110;
	var buttonActionListLength = array_length(buttonActionList)
	for(var i = 0; i < buttonActionListLength;i++){
		
		if(!instance_exists(buttonActionList[i][0])){
			instance_create_layer(
				floor(buttonXOffset+lengthdir_x(20,spawnAngle)),
				floor(buttonYOffset-lengthdir_y(20,spawnAngle)),
				layer_get_id("layerGUI"),
				buttonActionList[i][0],
				{	
					actionDescription: buttonActionList[i][1],
					buttonPlayerCharaParent: id
				});
			}
		spawnAngle += 50;
	}
}

function DeletePlayerActionMenu(){
	
	for(var i = 0; i < array_length(buttonActionList);i++){
		if(instance_exists(buttonActionList[i][0])){
			buttonActionList[i][0].deleteSelf = true;
		}
	}
}

function CreateProyectileMeter(){
	
	if(!instance_exists(oProyectileMeter)){
		instance_create_layer(
			x+other.sprite_width*0.65,
			y-other.sprite_height*0.5,
			layer_get_id("layerGUI"),
			oProyectileMeter,
			{parentChara: other.id}
		);	
	}
}

function CreateStrengthMeter(){
	
	if(!instance_exists(oStrengthMeter)){
		
		instance_create_layer(
		x+other.sprite_width*0.35,
		y-other.sprite_height*0.5,
		layer_get_id("layerGUI"),
		oStrengthMeter,
		{parentChara: other.id}
		);	
		
	}
}

function PlayerHealAllTeammates(){
	
	for(var i = 0; i < global.playerCharasOnBattle; i++){
			
		var playerCharaToHeal = oBattleManager.playerCharasOnBattleList[|i];
		var prevHealth = playerCharaToHeal.charaHP;
		playerCharaToHeal.charaHP += charaRegen;
		var currentHealth = playerCharaToHeal.charaHP;
		healedcharaHP = currentHealth-prevHealth;
		if(playerCharaToHeal.charaHP > playerCharaToHeal.maxcharaHP)playerCharaToHeal.charaHP = playerCharaToHeal.maxcharaHP;
	
		//create number of heal done above the target
		instance_create_depth(
			playerCharaToHeal.damageNumberXOffset,
			playerCharaToHeal.damageNumberYOffset,
			depth,
			oHealNumber,
			{healTaken: healedcharaHP}
			);
		instance_create_layer(
			playerCharaToHeal.x,
			playerCharaToHeal.y,
			layer_get_id("layerGUI"),
			oEffect,
			{sprite_index: sHealEffect}
		
		
		);
	}	
}

function PlayerShotAttack(targetToShot,proyectileSprite,proyectileSpeed,animLoopLastFrame,animLoopFirstFrame){
	
	DeletePlayerActionMenu();
	
	if(sprite_index != sprAttack){
		sprite_index = sprAttack;
		localFrame = 0;
	}
	
	AnimateSprite();
	
	if(!instance_exists(oProyectileMeter) && floor(localFrame) == animLoopFirstFrame)CreateProyectileMeter();
	
	if(floor(localFrame) == animLoopLastFrame && !performAttack)localFrame = animLoopFirstFrame;
	
	if(performAttack && !instance_exists(oLinearProyectile)){
		CreateHitLinearProyectile(targetToShot,proyectileSpeed,true,proyectileSprite);
		performAttack = false;
		localFrame = animLoopLastFrame+1;
	}
	
	if(animationEnd)charaState = charaStateWait;
	
}
	
function PlayerSplashAttack(proyectileSprite,proyectileSpeed,animLoopLastFrame,animLoopFirstFrame){
	
	
	DeletePlayerActionMenu();
	
	if(sprite_index != sprAttack){
		sprite_index = sprAttack;
		localFrame = 0;
	}
	
	AnimateSprite();
	
	if(!instance_exists(oStrengthMeter) && floor(localFrame) == animLoopFirstFrame)CreateStrengthMeter();
	
	if(floor(localFrame) == animLoopLastFrame && !performAttack)localFrame = animLoopFirstFrame;	
	
	if(performAttack && !instance_exists(oParabolicProyectile)){
		CreateHitParabProyectile(oBattleManager.enemiesOnBattleList[|0],proyectileSpeed,true,proyectileSprite);
		performAttack = false;
		localFrame = animLoopLastFrame+1;
	}
	if(animationEnd) charaState = charaStateWait;
		
	
}


function PlayerCharaStateTurn(){
	
	//show_debug_message(string(id) + " chara damage " + string(charaDamage) + " charaDefense " + string(charaDefense));
	if(sprite_index != sprIdle){
		sprite_index = sprIdle;
	}
	AnimateSprite();
		
	DeployPlayerActionMenu();
		
	var keyConfirmAction = global.keyContinue;
	var keyCancelAction = global.keyCancel;
	keyConfirmPressedCount += keyConfirmAction-keyCancelAction;
	if(keyConfirmPressedCount < 0)keyConfirmPressedCount = 0;
		
	switch(keyConfirmPressedCount){
		case 0:{
			
			buttonSelected = SelectButtonWithKeys(buttonList);
			break;
		}
		case 1: {
			if(buttonSelected == oButtonPlayerSpecial && global.battlePoints < charaSpecialActCost 
				|| buttonSelected == oButtonPlayerAttack && global.battlePoints < charaAttackCost
				|| buttonSelected == oButtonPlayerHeal && global.battlePoints < charaHealCost){
				keyConfirmPressedCount--;
				break;
			}
			if(buttonSelected == oButtonPlayerAttack && playerChooseTargetToAtk) || ( buttonSelected == oButtonPlayerSpecial && playerChooseTargetToSpecial) || (buttonSelected == oButtonPlayerHeal && playerChooseTargetToHeal){
				enemyTarget = SelectEnemyWithKeys();
			}
			else keyConfirmPressedCount++;
			break;
		}
		case 2: {
			if(buttonSelected == oButtonPlayerSpecial)global.battlePoints -= charaSpecialActCost;
			if(buttonSelected == oButtonPlayerAttack)global.battlePoints -= charaAttackCost;
			if(buttonSelected == oButtonPlayerHeal)global.battlePoints -= charaHealCost;
			buttonSelected.executeAction = true;
			break;
		}
		default: break;
	}
	
}


function PlayerStateWait(){
	
	sprite_index = sprIdle;
	AnimateSprite();
	keyConfirmPressedCount = 0;
	//choose(sprHurt,sprHurt2);
	//reset values
	hitScreenShake = true;
	//currentSprHurt = sprHurt[(random_range(0,sprHurtListLength))];
		
}


function PlayerStateDefend(){
	
	if(sprite_index != sprDefense){
		DeletePlayerActionMenu();
		localFrame = 0;
		sprite_index = sprDefense;
		flash = 0.5;
		charaDefenseMod += BUFFMID;
		//charaBuffDuration += 1;
		instance_create_layer(x,y,layer_get_id("layerGUI"),oEffect,{sprite_index: sDefendEffect});
	}
	AnimateSprite();
	if(animationEnd)charaState = charaStateWait;
}

charaStateDefend = PlayerStateDefend;
charaStateTurn = PlayerCharaStateTurn;
charaStateWait = PlayerStateWait;
charaState = PlayerStateWait;


global.combatState = COMBAT_STATE.PLAYER_TURN;

