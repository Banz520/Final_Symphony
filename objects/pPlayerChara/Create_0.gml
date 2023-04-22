//@desc Basic Chara functs
event_inherited();

//reset enemy selected
enemySelected = 0;

performAttack = false;

function SelectEnemyWithKeys(){
	
	//Select enemy to interact with
	var keySelectLeft = (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up))*-1;
	var keySelectRight = (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down));
			
	//keep selection on the enemy list number range
	if(enemySelected <= (global.enemiesOnBattle-1) && enemySelected >= 0){
		enemySelected += keySelectLeft+keySelectRight;
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
	with(enemyTarget) flash = 0.5;
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

		
function PlayerCharaStateTurn(){
	
	if(sprite_index != sprIdle){
		charaDamageMod = 1;
		sprite_index = sprIdle;
	}
	AnimateSprite();
		
	DeployPlayerActionMenu();
		
	var keyConfirmAction = keyboard_check_pressed(vk_space);
	var keyCancelAction = keyboard_check_pressed(vk_tab);
	keyConfirmPressedCount += keyConfirmAction-keyCancelAction;
	if(keyConfirmPressedCount < 0)keyConfirmPressedCount = 0;
		
	switch(keyConfirmPressedCount){
		case 0:{
			
			buttonSelected = SelectButtonWithKeys(buttonList);
			break;
		}
		case 1: {
			if(buttonSelected == oButtonPlayerSpecial && global.battlePoints < charaSpecialActCost || buttonSelected == oButtonPlayerAttack && global.battlePoints < charaAttackCost)keyConfirmPressedCount--;
			if(buttonSelected == oButtonPlayerAttack || buttonSelected == oButtonPlayerSpecial)enemyTarget = SelectEnemyWithKeys();
			else keyConfirmPressedCount++;
			break;
		}
		case 2: {
			if(buttonSelected == oButtonPlayerSpecial)global.battlePoints -= charaSpecialActCost;
			if(buttonSelected == oButtonPlayerAttack)global.battlePoints -= charaAttackCost;
			buttonSelected.executeAction = true;
			break;
		}
		default: break;
	}
	
}

function PlayerShotAttack(targetToShot,proyectileSprite,proyectileSpeed,animLoopLastFrame,animLoopFirstFrame){
	
	DeletePlayerActionMenu();
	
	if(sprite_index != sprAttack){
		sprite_index = sprAttack;
		CreateProyectileMeter();
	}
	
	AnimateSprite();
	
	if(floor(localFrame) == animLoopLastFrame && !performAttack)localFrame = animLoopFirstFrame;
	
	if(performAttack && !instance_exists(oLinearProyectile)){
		CreateHitLinearProyectile(targetToShot,proyectileSpeed,true,proyectileSprite);
		performAttack = false;
		localFrame = animLoopLastFrame+1;
	}
	
	if(animationEnd)charaState = charaStateWait;
	
}
	
function PlayerSplashAttack(targetToThrow,proyectileSprite,proyectileSpeed,animLoopLastFrame,animLoopFirstFrame){
	
	
	DeletePlayerActionMenu();
	
	if(sprite_index != sprAttack){
		sprite_index = sprAttack;
		CreateStrengthMeter();
	}
	
	AnimateSprite();
	if(floor(localFrame) == animLoopLastFrame && !performAttack)localFrame = animLoopFirstFrame;
	
	if(performAttack && !instance_exists(oParabolicProyectile)){
		CreateHitParabProyectile(targetToThrow,proyectileSpeed,true,proyectileSprite);
		performAttack = false;
		localFrame = animLoopLastFrame+1;
	}
	if(animationEnd) charaState = charaStateWait;
		
	
}

charaStateTurn = PlayerCharaStateTurn;
