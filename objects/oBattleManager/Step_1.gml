/// @description CheckWinOrLose & Turns

battleTimer += 25 * delta_time / 1000000;

if(global.keyCancel &&  global.combatState == COMBAT_STATE.PLAYER_ACT)changePlayerCharaSelected =  true;


if(battleTimer > 13 || global.combatState == COMBAT_STATE.PLAYER_TURN){
	
	if(!CheckWinOrLose())SetTurns();
	battleTimer = 0;
}

if(instance_exists(enemyTurnText)){
	
	var xRandomRange = 0.8;
	var yRandomRange = 0.3;
	enemyTurnText.x += random_range(-xRandomRange, xRandomRange);
	enemyTurnText.y += random_range(-yRandomRange, yRandomRange);
	
}


if(instance_exists(playerTurnText)){
	
	var xRandomRange = 0.8;
	var yRandomRange = 0.3;
	playerTurnText.x += random_range(-xRandomRange, xRandomRange);
	playerTurnText.y += random_range(-yRandomRange, yRandomRange);
}

