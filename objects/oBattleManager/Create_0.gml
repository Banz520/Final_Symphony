/// @description Set Variables & functs


global.enemiesOnBattle = 0;
global.playerCharasOnBattle = 0;

global.battlePointsForEnemyDefeat = 2;
global.battlePointsForPerfectAct = 0.5;

battlePointsPerTurn = 5;
battlePointsInit = 6;

turnCount = 1;

battleTimer = 0;


keySelectPlayerCharaCount = 0;
playerCharaSelected = 0;
changePlayerCharaSelected = false;

enemyTurnText = noone;
playerTurnText = noone;

function CreateEnemiesFromList(){
	
	enemiesOnBattleList = ds_list_create();

	//spawn enemys and add to list
	for(var i = 0; i < array_length(global.battleEnemySpawnList); i++){
	
		global.enemiesOnBattle++;
	
		var enemySpawn = instance_find(oEnemySpawn,i+global.spawnDistance);
	 
		var currentEnemy = instance_create_depth(
				enemySpawn.x,
				enemySpawn.y,
				depth+power(-1,i),
				global.battleEnemySpawnList[i]
				);
	
		ds_list_add(enemiesOnBattleList,currentEnemy);
	
	}	
}
	
function CreatePlayerCharasFromList(){
	
	playerCharasOnBattleList = ds_list_create();

	//spawn player charas and add to list
	for(var i = 0; i < array_length(global.battlePlayerCharaSpawnList); i++){
	
		global.playerCharasOnBattle++;
	
		var playerCharaSpawn = instance_find(oPlayerCharaSpawn,i+global.spawnDistance);
	 
		var currentPlayerChara = instance_create_depth(
				playerCharaSpawn.x,
				playerCharaSpawn.y,
				depth+power(-1,i),
				global.battlePlayerCharaSpawnList[i]
				);
	
		ds_list_add(playerCharasOnBattleList,currentPlayerChara);
	
	}
	
}

function CheckWinOrLose(){
	
	if(global.enemiesOnBattle <= 0){
		
		global.combatState = COMBAT_STATE.WIN;	
		RoomTransition(TRANS_TYPE.FADE,rLevelMenu);
		return true;
		
	}
	else if(global.playerCharasOnBattle <= 0){
		
		global.combatState = COMBAT_STATE.DEFEAT;	
		RoomTransition(TRANS_TYPE.FADE,rLevelMenu);
		return true;
	}
}



function SelectPlayerCharaWithKeys(){
	
	var playerCharasToUseList = [];
	var toUseListIndex = 0;
	//save the available charas and the pos of the selected
	for(var i = 0; i < global.playerCharasOnBattle; i++){
		
		if(!playerCharasOnBattleList[|i].playerCharaUsedTurn){
			
			array_insert(playerCharasToUseList,toUseListIndex,playerCharasOnBattleList[|i]);
			toUseListIndex++;
		}
	}
	
	var playerCharasToUseLength = array_length(playerCharasToUseList);
	if(playerCharasToUseLength <= 0) return noone;
	
	//Select chara to interact with
	var keySelectLeft = (global.keyPrevLeft || global.keyNextUp);
	var keySelectRight = (global.keyNextRight || global.keyPrevDown)*-1;

	playerCharaSelected = (playerCharaSelected % playerCharasToUseLength + playerCharasToUseLength) % playerCharasToUseLength;
	
	var lastPlayerCharaSelectedId = noone;
	if(playerCharasToUseLength > 1)lastPlayerCharaSelectedId = playerCharasToUseList[playerCharaSelected];
	
	playerCharaSelected += keySelectLeft + keySelectRight;
	playerCharaSelected = (playerCharaSelected % playerCharasToUseLength + playerCharasToUseLength) % playerCharasToUseLength;
	//playerCharaSelected = max(playerCharaSelected,0);
	
	var playerCharaSelectedId = playerCharasToUseList[playerCharaSelected];
	
	playerCharaSelectedId.playerCharaIsHover = true;
	playerCharaSelectedId.flash = 0.5;

	if(instance_exists(lastPlayerCharaSelectedId)) && (lastPlayerCharaSelectedId.id != playerCharaSelectedId.id)lastPlayerCharaSelectedId.playerCharaIsHover = false;
	
	return playerCharaSelectedId;

}

function PlayerTurn(){
	
	if(instance_exists(playerTurnText)){
					
		playerTurnTextTimer += 25 * delta_time / 1000000;
		if(playerTurnTextTimer > 13){
			instance_destroy(playerTurnTextOutline1);
			instance_destroy(playerTurnTextOutline2);
			instance_destroy(playerTurnText);
		}
	}
				
	var keySelectPlayerChara = global.keyContinue;
	keySelectPlayerCharaCount += keySelectPlayerChara;
				
	if(keySelectPlayerCharaCount < 1){
					
		currentPlayerCharaOnTurn = SelectPlayerCharaWithKeys();
		if(currentPlayerCharaOnTurn == noone){
			
			changePlayerCharaSelected = false;
			keySelectPlayerCharaCount = 0;
			playerCharaTurns = global.playerCharasOnBattle;
			playerCharaSelected++;
			global.combatState = COMBAT_STATE.WAIT;
		}
	}
	else if(keySelectPlayerCharaCount >= 1){
					
		if(instance_exists(currentPlayerCharaOnTurn)){
					
			if(currentPlayerCharaOnTurn.charaState != currentPlayerCharaOnTurn.charaStateHurt) {
							
				currentPlayerCharaOnTurn.playerCharaIsHover = false;
				currentPlayerCharaOnTurn.charaState = currentPlayerCharaOnTurn.charaStateTurn;
				changePlayerCharaSelected = false;
				global.combatState = COMBAT_STATE.PLAYER_ACT;
				keySelectPlayerCharaCount = 0;

			}
		}
	}
	
}

function EnemyTurn(){
	
	if(instance_exists(enemyTurnText)){
			instance_destroy(enemyTurnTextOutline1);
			instance_destroy(enemyTurnTextOutline2);
			instance_destroy(enemyTurnText);
	}
	if(instance_exists(currentEnemyOnTurn)){
		if(currentEnemyOnTurn.charaState != currentEnemyOnTurn.charaStateHurt){
					
			currentEnemyOnTurn.charaState = currentEnemyOnTurn.charaStateTurn;
					
			global.combatState = COMBAT_STATE.ENEMY_ACT;
		}
	}
			
	else enemyOnTurnCount = 0;	
}
	
function EnemyAct(){
	
	if(instance_exists(currentEnemyOnTurn))&&(currentEnemyOnTurn.charaState == currentEnemyOnTurn.charaStateWait){
		//set next enemy to activate
		if(enemyOnTurnCount < global.enemiesOnBattle-1){
						
			enemyOnTurnCount++;
			global.combatState = COMBAT_STATE.ENEMY_TURN;	
		}
		else{
						
			enemyOnTurnCount = 0;
			//up battle points per turn
			if(global.battlePoints < MAX_BATTLEPOINTS)global.battlePoints += battlePointsPerTurn;
			global.combatState = COMBAT_STATE.WAIT;
		}
	}
}

function SetTurns(){

	//currentPlayerCharaOnTurn = playerCharasOnBattleList[|0];
	currentEnemyOnTurn = enemiesOnBattleList[|enemyOnTurnCount];
	
	if(!instance_exists(oHitMarker) && !instance_exists(oParabolicProyectile) && !instance_exists(oLinearProyectile)){
	
		switch(global.combatState){
		
			case COMBAT_STATE.PLAYER_TURN:{
				
				PlayerTurn();
				
				break;
			}
		
			case COMBAT_STATE.PLAYER_ACT:{
				
				if(instance_exists(playerTurnText)){
						instance_destroy(playerTurnTextOutline1);
						instance_destroy(playerTurnTextOutline2);
						instance_destroy(playerTurnText);
				}
				
				//Change Player Chara Selected
				if(changePlayerCharaSelected){
					currentPlayerCharaOnTurn.charaState = currentPlayerCharaOnTurn.charaStateWait;
					currentPlayerCharaOnTurn.DeletePlayerActionMenu();
					global.combatState = COMBAT_STATE.PLAYER_TURN;
					break;
				}
				
				//Choose Action with chara selected
				
				if(instance_exists(currentPlayerCharaOnTurn))&&(currentPlayerCharaOnTurn.charaState == currentPlayerCharaOnTurn.charaStateWait){
					//set next playerchara to activate
					playerCharaSelected++;
					if(playerCharaTurns > 0){
						
						playerCharaTurns--;
						currentPlayerCharaOnTurn.playerCharaUsedTurn = true;
						currentPlayerCharaOnTurn.flash = 0.5;
						global.combatState = COMBAT_STATE.PLAYER_TURN;	
					}
				
					else{
						
						playerCharaTurns = global.playerCharasOnBattle;
						global.combatState = COMBAT_STATE.WAIT;
					}
				}
				
				break;
			}
		
			case COMBAT_STATE.ENEMY_TURN:{
			
				EnemyTurn();
			
				break;
			}
		
			case COMBAT_STATE.ENEMY_ACT:{
					
				EnemyAct();
				break;
			
			}	
		
			case COMBAT_STATE.WAIT:{
									
				
				if(!instance_exists(oHitMarker) && !instance_exists(oParabolicProyectile) && !instance_exists(oLinearProyectile)){
					turnCount++;
					if(turnCount%2 == 1){
						
						playerTurnText = instance_create_layer(RES_WIDTH * 0.5,RES_HEIGHT/3,layer_get_id("layerGUI"),oText,{textFont: fPixelText, textColor: c_white, textToDraw: "YOUR TURN!"});
						playerTurnTextOutline1 = instance_create_layer((RES_WIDTH * 0.5) + 1,(RES_HEIGHT/3) + 1,layer_get_id("layerGUI"),oText,{textFont: fPixelText, textColor: c_blue, textToDraw: "YOUR TURN!"});
						playerTurnTextOutline2 = instance_create_layer((RES_WIDTH) * 0.5 - 1,(RES_HEIGHT/3) - 1,layer_get_id("layerGUI"),oText,{textFont: fPixelText, textColor: c_blue, textToDraw: "YOUR TURN!"});
						playerTurnTextTimer = 0;
						playerCharaSelected = 0;
						
						global.combatState = COMBAT_STATE.PLAYER_TURN;
						//reset buffs
						for(var i = 0; i < global.playerCharasOnBattle; i++){
							playerCharasOnBattleList[|i].playerCharaUsedTurn = false;
							if(playerCharasOnBattleList[|i].charaBuffDuration <= 0){
								playerCharasOnBattleList[|i].charaDamageMod = 1;
								playerCharasOnBattleList[|i].charaDefenseMod = 1;
							}
							else playerCharasOnBattleList[|i].charaBuffDuration--;
						}
					}
					else{
						
						
						enemyTurnText = instance_create_layer(RES_WIDTH * 0.5,RES_HEIGHT/3,layer_get_id("layerGUI"),oText,{textFont: fPixelText, textColor: c_white, textToDraw: "ENEMY TURN!"});
						enemyTurnTextOutline1 = instance_create_layer((RES_WIDTH * 0.5) + 1,(RES_HEIGHT/3) + 1,layer_get_id("layerGUI"),oText,{textFont: fPixelText, textColor: c_red, textToDraw: "ENEMY TURN!"});
						enemyTurnTextOutline2 = instance_create_layer((RES_WIDTH) * 0.5 - 1,(RES_HEIGHT/3) - 1,layer_get_id("layerGUI"),oText,{textFont: fPixelText, textColor: c_red, textToDraw: "ENEMY TURN!"});
						global.combatState = COMBAT_STATE.ENEMY_TURN;
						//reset playercharas alpha
						for(var i = 0; i < global.playerCharasOnBattle; i++){
							playerCharasOnBattleList[|i].playerCharaUsedTurn = false;
						}
						//reset buffs
						for(var i = 0; i < global.enemiesOnBattle; i++){
							if(enemiesOnBattleList[|i].charaBuffDuration <= 0){
								enemiesOnBattleList[|i].charaDamageMod = 1;
								enemiesOnBattleList[|i].charaDefenseMod = 1;
							}
							else enemiesOnBattleList[|i].charaBuffDuration--;
							
							if(enemiesOnBattleList[|i].enemyTauntDuration <= 0)enemiesOnBattleList[|i].enemyTauntTarget = noone;
							else enemiesOnBattleList[|i].enemyTauntDuration--;
						}
					}
				}
				
				break;
			}
		
		}//switch
	}
	
}	
