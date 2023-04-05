
	
function CreateDamageNumber(target,totalDamage){
	
	
	//create number of damage done above the target
	instance_create_layer(
		target.damageNumberXOffset,
		target.damageNumberYOffset,
		layer_get_id("layerGUI"),
		oDamageNumber,
		{damageTaken: totalDamage}
	);
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
	