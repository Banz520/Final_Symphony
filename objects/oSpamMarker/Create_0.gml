/// @description 
localFrame = 0;
blockCounter = 0;
blockCounterLimit = 10;

// Get the perfect frame for a given sprite index
//perfectFrame = ds_map_find_value(oBattleManager.perfectFrames, sprite_index);
keyPressAlertOnTarget = noone;

defense = target.charaDefense - 1;

if(!instance_exists(oEffect)){
	
	keyPressAlertOnTarget = oBattleManager.playerCharasOnBattleList[|0].DrawKeyPressAlert();
	
}

function HurtChara(defenseFromTarget , damageFromAttacker) {
	
	var totalDamage = damageFromAttacker - defenseFromTarget;
	totalDamage = max(1,totalDamage);
	totalDamage = round(totalDamage);
	target.charaHP -= totalDamage;
	CreateDamageNumber(target,totalDamage);
	target.charaState = target.charaStateHurt;
		
}
		
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
	