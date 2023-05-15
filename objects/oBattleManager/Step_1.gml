/// @description CheckWinOrLose & Turns

battleTimer += 25* delta_time / 1000000;

if(battleTimer > 13 || global.combatState == COMBAT_STATE.PLAYER_TURN){
	
	if(!CheckWinOrLose())SetTurns();
	battleTimer = 0;
}

if(instance_exists(enemyTurnText)){
	enemyTurnText.x += random_range(-0.5,0.5);
	enemyTurnTextOutline1.x = enemyTurnText.x + 1;
	enemyTurnTextOutline2.x = enemyTurnText.x - 1;
}


if(instance_exists(playerTurnText)){
	playerTurnText.x += random_range(-0.5,0.5);
	playerTurnTextOutline1.x = playerTurnText.x + 1;
	playerTurnTextOutline2.x = playerTurnText.x - 1;
	
}

