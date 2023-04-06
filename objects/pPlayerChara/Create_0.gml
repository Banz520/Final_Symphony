// Inherit the parent event
event_inherited();

//reset enemy selected
enemySelected = 0;


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
	for(var i = 0; i < array_length(buttonActionList);i++){
		
		if(!instance_exists(buttonActionList[i])){
			instance_create_layer(
				floor(buttonXOffset+lengthdir_x(20,spawnAngle)),
				floor(buttonYOffset-lengthdir_y(20,spawnAngle)),
				layer_get_id("layerGUI"),
				buttonActionList[i],
				{buttonPlayerCharaParent: other.id});
			}
		spawnAngle += 50;
	}
}

function DeletePlayerActionMenu(){
	
	for(var i = 0; i < array_length(buttonActionList);i++){
		if(instance_exists(buttonActionList[i])){
			buttonActionList[i].deleteSelf = true;
		}
	}
}
