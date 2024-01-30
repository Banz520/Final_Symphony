/// @description 

// Inherit the parent event
event_inherited();

linearProyectileSpawnOriginX = x + sprite_get_width(sprAttack) * 0.5;

playerChooseTargetToAtk = true;

function TechnoAttack(){
	
	PlayerShotAttack(enemyTarget,PROYECTILE_SPR.ROCKET,4.5,12,7);
	
}



//Declare Character States
charaStateAttack = TechnoAttack;
charaStateSpecial = TechnoAttack

SetAtkValueToShootDesc();

buttonActionList = [
	[oButtonPlayerAttack,shotAtkDesc],
	[oButtonPlayerDefend,defenseDesc],
	[oButtonPlayerSpecial,"special"]
	
];

SetButtonList();