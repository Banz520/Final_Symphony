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
					//activate playercharaTurn
					currentPlayerCharaOnTurn.charaState = currentPlayerCharaOnTurn.charaStateTurn;
					global.combatState = COMBAT_STATE.PLAYER_ACT;
					//show_debug_message(global.battlePoints);
				}// if playerchara not hurt and not attacks being perform
				break;
			}// if playerchara exist
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
			}// if player charastatewait 
				
			break;
		}
		
		case COMBAT_STATE.ENEMY_TURN:{
			
			if(instance_exists(currentEnemyOnTurn)){
				if(currentEnemyOnTurn.charaState != currentEnemyOnTurn.charaStateHurt 
					&& !instance_exists(oHitMarker) 
					&& !instance_exists(oParabolicProyectile) 
					&& !instance_exists(oLinearProyectile)) 
					//&& oPlayer.charaState != oPlayer.charaStateHurt)
					{
					//activate enemyTurn
					currentEnemyOnTurn.charaState = currentEnemyOnTurn.charaStateTurn;
					global.combatState = COMBAT_STATE.ENEMY_ACT;
				}// if enemy not hurt and not attacks being perform
				break;
			}// if enemy exist
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
					if(global.battlePoints < 10)global.battlePoints++;
					global.combatState = COMBAT_STATE.WAIT;
				}
			}// if enemystatewait 
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
			
	}//switch
}	
