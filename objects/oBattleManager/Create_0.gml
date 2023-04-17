/// @description Set Variables & functs


global.enemiesOnBattle = 0;
global.playerCharasOnBattle = 0;
turnCount = 1;

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
	}
	else if(global.playerCharasOnBattle <= 0){
		
		global.combatState = COMBAT_STATE.DEFEAT;	
		RoomTransition(TRANS_TYPE.FADE,rLevelMenu);
	}
}


function SetTurns(){

	currentPlayerCharaOnTurn = playerCharasOnBattleList[|playerCharaOnTurnCount];
	currentEnemyOnTurn = enemiesOnBattleList[|enemyOnTurnCount];
	
	switch(global.combatState){
		
		case COMBAT_STATE.PLAYER_TURN:{
			
			if(instance_exists(currentPlayerCharaOnTurn)){
				if(currentPlayerCharaOnTurn.charaState != currentPlayerCharaOnTurn.charaStateHurt 
					&& !instance_exists(oHitMarker) 
					&& !instance_exists(oParabolicProyectile) 
					&& !instance_exists(oLinearProyectile)){
					
					currentPlayerCharaOnTurn.charaState = currentPlayerCharaOnTurn.charaStateTurn;

					global.combatState = COMBAT_STATE.PLAYER_ACT;

				}// if playerchara not hurt and not attacks being perform
				break;
			}
			else{
				playerCharaOnTurnCount = 0;
				break;
			}
		
		}
		
		case COMBAT_STATE.PLAYER_ACT:{
				
			if(instance_exists(currentPlayerCharaOnTurn))&&(currentPlayerCharaOnTurn.charaState == currentPlayerCharaOnTurn.charaStateWait){
				//set next playerchara to activate
				if(playerCharaOnTurnCount < global.playerCharasOnBattle-1){
						
					playerCharaOnTurnCount++;
					global.combatState = COMBAT_STATE.PLAYER_TURN;	
				}
				
				else{
					playerCharaOnTurnCount = 0;
					global.combatState = COMBAT_STATE.WAIT;
				}
			}
			break;
		}
		
		case COMBAT_STATE.ENEMY_TURN:{
			
			if(instance_exists(currentEnemyOnTurn)){
				if(currentEnemyOnTurn.charaState != currentEnemyOnTurn.charaStateHurt 
					&& !instance_exists(oHitMarker) 
					&& !instance_exists(oParabolicProyectile) 
					&& !instance_exists(oLinearProyectile)) 
					{
					
					currentEnemyOnTurn.charaState = currentEnemyOnTurn.charaStateTurn;
					
					global.combatState = COMBAT_STATE.ENEMY_ACT;
				}// if enemy not hurt and not attacks being perform
				break;
			}
			
			else{
				enemyOnTurnCount = 0;
				break;
			}
		}
		
		case COMBAT_STATE.ENEMY_ACT:{
				
			if(instance_exists(currentEnemyOnTurn))&&(currentEnemyOnTurn.charaState == currentEnemyOnTurn.charaStateWait){
				//set next enemy to activate
				if(enemyOnTurnCount < global.enemiesOnBattle-1){
						
					enemyOnTurnCount++;
					global.combatState = COMBAT_STATE.ENEMY_TURN;	
				}
				else{
						
					enemyOnTurnCount = 0;
					if(global.battlePoints < MAX_BATTLEPOINTS)global.battlePoints += 3;
					global.combatState = COMBAT_STATE.WAIT;
				}
			}
			break;
			
		}	
		
		case COMBAT_STATE.WAIT:{
			
			if(!instance_exists(oHitMarker) && !instance_exists(oParabolicProyectile) && !instance_exists(oLinearProyectile)){
				turnCount++;
				if(turnCount%2 == 1){
					global.combatState = COMBAT_STATE.PLAYER_TURN;
				}
				else{
					global.combatState = COMBAT_STATE.ENEMY_TURN;
				}
			}
			break;
		}
		
		case COMBAT_STATE.HURT:{
			
			
		}
	}//switch
	
}	
