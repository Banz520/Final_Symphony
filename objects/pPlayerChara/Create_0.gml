//@desc Basic Chara functs
event_inherited();

// --GUI--
buttonXOffset = x;
buttonYOffset = y - sprite_height * 0.75;

playerCharaUsedTurn = false;

enemySelected = 0;
enemyTarget = noone;

charaToInteractSelected = 0;
charaToInteract = noone;
playerCharaToInteractSelected = 0;
actionSelected = 0;
 
keyConfirmPressedCount = 0;
buttonSelected = 0;

performAttack = false;

playerChooseTargetToAtk = true;
playerChooseTargetToHeal = true;
playerChooseTargetToSpecial = true;

playerCharaDescriptionBox = noone;
playerCharaDrawDescBox = false;

friendList = [-1];
friendListOnLevel = [];

buttonActionList = [-1];

// --ACTION DESCS--
defenseDescEN = "Rises defense for the next turn and\nsave wasting chaos points"
defenseDesc = defenseDescEN;

hitAtkDesc = "Perform a melee attack on the selected\nenemy";

shotAtkDesc = "Shot the selected enemy dealing  points of base\ndamage to all enemies the proyectile pierces through\non its path to the target!";

throwAtkDesc = "Attack all enemies dealing  points\nof damage!";

interactDescEN = "Interact with the selected character\nUse [C] to change the team selection";
interactDesc = interactDescEN;

charaFirstName = string_split(charaName," ");
interactionDefaulText = string(charaFirstName[0] + " doesn't know this person enough to\ninteract with...");

dialogueGlobe = noone;

warningDialogue = "Watch out!";

hasSpokenOnThisTurn = false;
sayWarningDialogue = 2;

charasToInteractList = [ [] ];
charaInteractionBox = noone;
charaInteractionGlobe = noone;

keyChangeSelectToInteract = false;


function SetAtkValueToThrowDesc(){
	
	textCharaDamageBase = string(charaDamageBase);
	
	if(oGame.gameLanguage == LANGUAGE.ENGLISH) {
	
		throwAtkDesc = string_insert(textCharaDamageBase,throwAtkDesc,28);
	}
	
	else {
		
		throwAtkDesc = string_insert(textCharaDamageBase,throwAtkDesc,41);
	}
}

function SetAtkValueToShootDesc(){

	textCharaDamageBase = string(charaDamageBase);
	
	if(oGame.gameLanguage == LANGUAGE.ENGLISH) {
	
		shotAtkDesc = string_insert(textCharaDamageBase,shotAtkDesc,33);
	}
	
	else {
		
		shotAtkDesc = string_insert(textCharaDamageBase,shotAtkDesc,46);
	}
}

function DrawWarnDialogue(warningPhrase){
	
	for(var friendOnList = 0; friendOnList < array_length(friendListOnLevel); friendOnList++){
		
		if(instance_exists(oBattleManager.currentEnemyOnTurn)) && (oBattleManager.currentEnemyOnTurn.playerCharaTarget == friendListOnLevel[friendOnList]) && (!instance_exists(dialogueGlobe)){
			
			friendName = string_split(friendListOnLevel[friendOnList].charaName," ");
			warningGlobeText = string(friendName[0] + "\n" + warningPhrase);
			
			DrawTextGlobe(warningGlobeText);
			hasSpokenOnThisTurn = true;
		}
	}	
	
}

function DrawPlayerCharaDescBox () {
	
	if(!instance_exists(playerCharaDescriptionBox)){
			playerCharaDescriptionBox = instance_create_layer(8,8,layer_get_id("layerGUI"),oTextBox,{
				description1: string("{0}\nAtk: {1}  Def: x{2}",charaName,charaDamage,charaDefense),
				hasSecondText: false,
				textColor1: c_white,
				image_xscale: 0,
				xscaleRate: 0.5,
				imageHeight: 20,
				showDesc: false,
				font: fPixelTextMini,
				textBoxWidth: RES_WIDTH*0.25
					
			});
		}	
}

function SetButtonList(){
	
	buttonList = [-1];
	for(var i = 0; i < array_length(buttonActionList); i++){
		buttonList[i] = buttonActionList[i][0];	
	}
	
}

function SelectEnemyTarget(){
	
	var enemiesToSelect = global.enemiesOnBattle;
	
	//Select enemy to interact with
	var keySelectLeft = (global.keyPrevLeft || global.keyNextUp)*-1;
	var keySelectRight = (global.keyNextRight|| global.keyPrevDown);
		
	enemySelected = (enemySelected % enemiesToSelect + enemiesToSelect) % enemiesToSelect;
	
	var lastEnemySelected = noone;
	lastEnemySelected = oBattleManager.enemiesOnBattleList[|enemySelected];
	
	//keep selection on the enemy list number range
	enemySelected += keySelectLeft + keySelectRight;		
	enemySelected = (enemySelected % enemiesToSelect + enemiesToSelect) % enemiesToSelect;
	
	var enemyTarget = oBattleManager.enemiesOnBattleList[|enemySelected];	
	enemyTarget.flash = 0.5;
	enemyTarget.charaIsHover = true;
	
	if(instance_exists(lastEnemySelected)) && (lastEnemySelected.id != enemyTarget.id) {
		lastEnemySelected.charaIsHover = false;
		
	}
	
	return enemyTarget;
}

function SelectPlayerCharaToInteract(){
	
	var playerCharasToUse = global.playerCharasOnBattle;
	
	//Select chara to interact with
	var keySelectLeft = (global.keyPrevLeft || global.keyNextUp);
	var keySelectRight = (global.keyNextRight || global.keyPrevDown)*-1;

	playerCharaToInteractSelected = (playerCharaToInteractSelected % playerCharasToUse + playerCharasToUse) % playerCharasToUse;
	
	var lastPlayerCharaSelectedId = noone;
	if(playerCharasToUse > 1)lastPlayerCharaSelectedId = oBattleManager.playerCharasOnBattleList[|playerCharaToInteractSelected];
	
	playerCharaToInteractSelected += keySelectLeft + keySelectRight;
	playerCharaToInteractSelected = (playerCharaToInteractSelected % playerCharasToUse + playerCharasToUse) % playerCharasToUse;
	//playerCharaSelected = max(playerCharaSelected,0);
	
	var playerCharaSelectedId = oBattleManager.playerCharasOnBattleList[|playerCharaToInteractSelected];
	
	playerCharaSelectedId.charaIsHover = true;
	playerCharaSelectedId.flash = 0.5;
	playerCharaSelectedId.playerCharaDrawDescBox = false;
	
	if(instance_exists(lastPlayerCharaSelectedId)) && (lastPlayerCharaSelectedId.id != playerCharaSelectedId.id) {
		
		lastPlayerCharaSelectedId.charaIsHover = false;
		
	}
	
	return playerCharaSelectedId;

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
	
	if(!instance_exists(oProyectileMeter) && !(instance_exists(oLinearProyectile))){
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
	
	if(!instance_exists(oStrengthMeter) && !(instance_exists(oParabolicProyectile))){
		
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
			
		playerCharaToHeal.DrawHealEffect();
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
	
function PlayerHitAttack(animAttackFrame, hitMarkSpr){
	
	DeletePlayerActionMenu();
	
	if(sprite_index != sprAttack){
		sprite_index = sprAttack;
		localFrame = 0;
	}
	
	AnimateSprite();
	
	if(localFrame == animAttackFrame)CreateHitMarker(enemyTarget, 1, hitMarkSpr, id);
	
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
	
	//Remove playerCharaDescBox
	if(instance_exists(playerCharaDescriptionBox))instance_destroy(playerCharaDescriptionBox);
	
	DeployPlayerActionMenu();
	
	//Input for action to select
	var keyConfirmAction = keyboard_check_pressed(oGame.keyContinue[1]) ||  keyboard_check_pressed(vk_space);
	var keyCancelAction = keyboard_check_pressed(oGame.keyCancel[1]);
	var keyOtherAction = keyboard_check_pressed(oGame.keyOther);
	keyConfirmPressedCount += keyConfirmAction - keyCancelAction;
	
	if(keyOtherAction)keyChangeSelectToInteract = !keyChangeSelectToInteract;
	
	if(keyConfirmPressedCount < 0)keyConfirmPressedCount = 0;
		
	switch(keyConfirmPressedCount){
		case 0:{
			
			buttonSelected = SelectButtonWithKeys(buttonList);
			//show_debug_message("case 0");
			break;
		}
		case 1: {
			//Take action if enough chaos points
			if(buttonSelected == oButtonPlayerSpecial && global.battlePoints < charaSpecialActCost 
				|| buttonSelected == oButtonPlayerAttack && global.battlePoints < charaAttackCost
				|| buttonSelected == oButtonPlayerHeal && global.battlePoints < charaHealCost
				|| buttonSelected == oButtonPlayerBuff && global.battlePoints < charaHealCost){
				keyConfirmPressedCount--;
				//show_debug_message("case 1");
				break;
			}
			//Select target to take action
			if(buttonSelected == oButtonPlayerAttack && playerChooseTargetToAtk 
				|| buttonSelected == oButtonPlayerSpecial && playerChooseTargetToSpecial
				|| buttonSelected == oButtonPlayerHeal && playerChooseTargetToHeal
				|| buttonSelected == oButtonPlayerBuff && playerChooseTargetToHeal){
					
				enemyTarget = SelectEnemyTarget();
			}
			else {
				
				//Select chara to interact
				if (buttonSelected == oButtonPlayerInteract){
					
					if (keyChangeSelectToInteract) {
						
						charaToInteractSelected = SelectPlayerCharaToInteract();
					}
					else {
						
						charaToInteractSelected = SelectEnemyTarget();	
					}
				}
				
				else {
					
					keyConfirmPressedCount++;
				
				}
			}
			//show_debug_message("case 1");
			break;
		}
		case 2: {
			//Lower chaos points used in action
			if(buttonSelected == oButtonPlayerSpecial)global.battlePoints -= charaSpecialActCost;
			if(buttonSelected == oButtonPlayerAttack)global.battlePoints -= charaAttackCost;
			if(buttonSelected == oButtonPlayerHeal || buttonSelected == oButtonPlayerBuff)global.battlePoints -= charaHealCost;
			
			buttonSelected.executeAction = true;
			//show_debug_message("case 2");
			
			break;
		}
		default: break;
	}
	
}


function PlayerStateWait(){
	
	if(playerCharaUsedTurn) image_alpha = 0.6;
	else image_alpha = 1;
	
	if(enemyTarget != noone && instance_exists(enemyTarget) && enemyTarget.charaIsHover == true)enemyTarget.charaIsHover = false;
	//if(charaToInteract != noone) && (charaToInteract.charaIsHover == true)charaToInteract.charaIsHover == false;
	
	sprite_index = sprIdle;
	AnimateSprite();
	keyConfirmPressedCount = 0;
	//choose(sprHurt,sprHurt2);
	//reset values
	hitScreenShake = true;
	//currentSprHurt = sprHurt[(random_range(0,sprHurtListLength))];
	
	
	//Draw dialogue bubble if ally on danger
	if (sayWarningDialogue == 2){
		//50 % chance of dialogue to be said each turn
		sayWarningDialogue = choose(0,1);
		//show_debug_message(sayWarningDialogue);
	}
	
	if(sayWarningDialogue) && (!hasSpokenOnThisTurn) && (global.combatState == COMBAT_STATE.ENEMY_ACT || global.combatState == COMBAT_STATE.ENEMY_TURN){
		DrawWarnDialogue(warningDialogue);
	}
	
	
	//Show character description textbox
	if(charaIsHover){
		
		//DrawSelectionArrow();
		if(playerCharaDrawDescBox){
			DrawPlayerCharaDescBox();
		
		}
	}
	else if(instance_exists(playerCharaDescriptionBox))instance_destroy(playerCharaDescriptionBox);
	
	if(instance_exists(charaInteractionBox))instance_destroy(charaInteractionBox);
}


function PlayerStateDefend(){
	
	if(sprite_index != sprDefense){
		DeletePlayerActionMenu();
		localFrame = 0;
		sprite_index = sprDefense;
		flash = 0.5;
		charaDefenseMod += BUFFMID;
		//charaBuffDuration += 1;
		DrawDefendEffect();
	}
	AnimateSprite();
	if(animationEnd)charaState = charaStateWait;
}

function DrawInteractionDesc(charaToInteractIndex){
	
	if(charaToInteractIndex != -1){
		
		if(!instance_exists(charaInteractionBox)){
			
			charaInteractionBox = instance_create_layer(8,8,layer_get_id("layerGUI"),oTextBox,{
				description1: charasToInteractList[charaToInteractIndex][1],
				hasSecondText: false,
				textColor1: c_white,
				image_xscale: 0,
				xscaleRate: 0.5,
				imageHeight: RES_HEIGHT * 0.25,
				showDesc: false,
				font: fPixelTextMini,
				textBoxWidth: RES_WIDTH * 0.5
					
			});
		}	
	}
	else{
		
		charaInteractionBox = instance_create_layer(8,8,layer_get_id("layerGUI"),oTextBox,{
				description1: interactionDefaulText,
				hasSecondText: false,
				textColor1: c_white,
				image_xscale: 0,
				xscaleRate: 0.5,
				imageHeight: RES_HEIGHT * 0.25,
				showDesc: false,
				font: fPixelTextMini,
				textBoxWidth: RES_WIDTH * 0.5
					
			});
		
	}
	
}

function PlayerInteractions(charaToInteractIndx, charaToInteractWith){
	
	switch(charaToInteractIndx){
			
		case 0:{
			
			
			//charaToInteractWith.charaDefenseMod += BUFFBIG;	
			
			break;
		}
		
		default: {
			
			show_debug_message("the charainteraction lead to nothing");	
			break;
		}
	}
	
}

function PlayerStateInteract(charaToInteract = charaToInteractSelected){
	
	
	if(sprite_index != sprInteract){
		DeletePlayerActionMenu();
		localFrame = 0;
		sprite_index = sprInteract;
		flash = 0.5;
		
		var charaToInteractInd = -1; 
		for(var i = 0; i < array_length(charasToInteractList);i++){
		
			if(charaToInteract.charaName == charasToInteractList[i][0]){
				charaToInteractInd = i;	
				break;
			}			
		
		}
	
		DrawInteractionDesc(charaToInteractInd);
	
		PlayerInteractions(charaToInteractInd,charaToInteract);
		charaInteractionGlobe = instance_create_layer(x,y - sprite_height - sprite_get_height(sTextGlobe),layer_get_id("layerGUI"),oEffect,{sprite_index: sInteractionGlobe});
		
	}
	AnimateSprite();
	
	
	if(animationEnd && !instance_exists(charaInteractionGlobe)){
		
		instance_destroy(charaInteractionBox);
		charaState = charaStateWait;
	}
}


charaStateDefend = PlayerStateDefend;
charaStateTurn = PlayerCharaStateTurn;
charaStateWait = PlayerStateWait;
charaState = PlayerStateWait;
charaStateInteract = PlayerStateInteract;

global.combatState = COMBAT_STATE.PLAYER_TURN;

