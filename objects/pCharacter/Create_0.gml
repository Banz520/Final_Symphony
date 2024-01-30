/// @description 

//chara stats
charaDamage = charaDamageBase + charaDamageMod;
charaDamagePrev = charaDamage;

charaHP = maxcharaHP;

charaDefenseBase = charaDefense;
charaDefensePrev = charaDefense;

charaBuffDuration = 0;

charaState = -1;

charaIsHover = false;

hitMarkerCreated = false;

linearProyectileSpawnOriginX = x;
linearProyectileSpawnOriginY = y - sprite_height * 0.4;

flash = 0;
flashDecrease = 0.2;
flashShader = 0;

//Sprite Set Up
sprite_index = sprIdle;
image_speed = 0;
localFrame = 0;


//GUI Set Up

damageNumberXOffset = x + 6;
damageNumberYOffset = y - sprite_height;

healthBarXOffset = round(x - sprite_get_width(sHealthBar) * 0.5);
healthBarYOffset = round(y + 4);

healthNumberX = healthBarXOffset + 7;
healthNumberY = healthBarYOffset + 2.25;

healthText = instance_create_layer(
				healthNumberX,
				healthNumberY,
				layer_get_id("layerGUI"),
				oText,
				{
					textToDraw: string(charaHP),
					textColor: c_black,
					textFont: fPixelTextMiniMicro,
					textHorizontalAlign: fa_center
				}
			);



function FindRelationCharasOnGame(relationList,listToSearch,relationListOnGame){
	
	var relationListOnGameSize = 0;
	
	//iterate for the listToSearch
	for(var charaOnSearchList = 0; charaOnSearchList < ds_list_size(listToSearch); charaOnSearchList++){
		
		var charaOnSearchListName = string(listToSearch[|charaOnSearchList].charaName);
		//show_debug_message("charaOnSearchListName: " + charaOnSearchListName);
		
		//iterate for the relationList to compare all elements with currentCharaName
		for(var charaOnRelationList = 0; charaOnRelationList < array_length(relationList); charaOnRelationList++){
			
			var charaNameOnRelationList = string(relationList[charaOnRelationList]);
			//show_debug_message("charaNameOnRelationList" + charaNameOnRelationList);
			
			//show_debug_message("string_pos: ");
			//show_debug_message(string_pos(charaNameOnRelationList,charaOnSearchListName));
			
			if(string_pos(charaNameOnRelationList,charaOnSearchListName) > 0){
				
				array_set(relationListOnGame,relationListOnGameSize, listToSearch[|charaOnSearchList]);
				relationListOnGameSize++;
				
				break;
			}
		}
		
	}
	
}



function CharaStateHurt(){
	
	if(sprite_index != sprHurt){
		sprite_index = sprHurt;
		localFrame = 0;
	}
	AnimateSprite(0.5);
		
	//screen shake
	hitScreenShake = true;
	if(hitScreenShake)ScreenShake(1.5,2);
	hitScreenShake = false;
	
	//flash
	flash = 0.5;
	flashShader = shWhiteFlash;
		
	//change state
	if(animationEnd)charaState = charaStateWait;
	
}

function CharaStateDead(){
	
	if(sprite_index != sprDead){
		sprite_index = sprDead;
		localFrame = 0;
	}
	AnimateSprite();
	if(animationEnd)instance_destroy();
	
}


//Declare Character States
charaStateWait = -1;
charaStateTurn = -1;
charaStateAttack = -1;
charaStateHurt = CharaStateHurt;
charaStateDead = CharaStateDead;
charaStateHeal = -1;
charaStateDefend = -1;
charaStateSpecial = -1;


function CreateHitMarker(targetToHit,dificulty = 0,spriteName,parentCharaid,damageToHit = parentCharaid.charaDamage){
	
	if(instance_exists(targetToHit)){
			
		instance_create_layer(
			targetToHit.x,
			targetToHit.y - targetToHit.sprite_height * 0.5,
			layer_get_id("layerGUI"),
			oHitMarker,
			{parentChara: parentCharaid,
			damageFromParent: damageToHit,
			target: targetToHit,
			dificultySpeed: dificulty,
			image_speed: 0,
			sprite_index: spriteName
			}
		);
	}
}


function CreateSpamMarker(targetToHit,dificulty = 0,spriteName,parentCharaid,damageToHit = parentCharaid.charaDamage){
	
	if(instance_exists(targetToHit)){
			
		instance_create_layer(
			targetToHit.x,
			targetToHit.y - targetToHit.sprite_height * 0.5,
			layer_get_id("layerGUI"),
			oSpamMarker,
			{parentChara: parentCharaid,
			damageFromParent: damageToHit,
			target: targetToHit,
			dificultySpeed: dificulty,
			image_speed: 0,
			sprite_index: spriteName
			}
		);
	}
}
	
	
function CreateHitParabProyectile(targetToHit,spd,attackByPlayer, proyectileSprite = 0, spamAttack = false){
	
	if(instance_exists(targetToHit)){
			
		instance_create_depth(
			x,
			y - other.sprite_height * 0.6,
			depth - 10,
			oParabolicProyectile,
			{charaDamage: other.charaDamage,
			target: targetToHit,
			vel: spd,
			parentChara: other.id,
			image_speed: 0,
			image_index: proyectileSprite,
			attackComesFromPlayer: attackByPlayer,
			createSpamMarker: spamAttack
			}
		);
	}
	
}
	
function CreateHitLinearProyectile(targetToHit,spd,attackByPlayer,proyectileSprite = 0){
	
	if(instance_exists(targetToHit)){
			
		instance_create_depth(
			linearProyectileSpawnOriginX,
			linearProyectileSpawnOriginY,
			depth-10,
			oLinearProyectile,
			{charaDamage: other.charaDamage,
			target: targetToHit,
			vel: spd,
			parentChara: other.id,
			image_speed:0,
			image_index: proyectileSprite,
			attackComesFromPlayer: attackByPlayer
			}
		);
	}
	
	
}


function FindMVPChara(charasOnTeam ,charaList) {
	
	var highestCharaTargetVal = 0, MVPchara = noone, currentChara = noone, currentCharaVal = 0;
	
	for(var i = 0; i < charasOnTeam; i++){
			
		currentChara = charaList[|i];
		show_debug_message(currentChara);
		currentCharaVal = currentChara.charaHP + currentChara.charaDamage;
		
		if(currentCharaVal > highestCharaTargetVal){
			highestCharaTargetVal = currentCharaVal;
			MVPchara = currentChara;
		}
		show_debug_message(MVPchara);
	}
	return MVPchara;
	
}

function FindLVPChara(charasTeam ,charaList) {
	
	var lowestCharaTargetVal = 1000,  LVPchara = noone, currentChara = noone, currentCharaVal = 0;
	
	for(var i = 0; i < charasTeam; i++){
			
		currentChara = charaList[|i];		
		currentCharaVal = currentChara.charaHP + currentChara.charaDamage;
		
		if(currentCharaVal < lowestCharaTargetVal){
			lowestCharaTargetVal = currentCharaVal;
			LVPchara = currentChara;
		}	
	}
	return LVPchara;
	
}


function DrawHealthBar(maxHealth,currentHealth){
	
	//draw healthbar
	draw_sprite(sHealthBar,1,healthBarXOffset,healthBarYOffset);
	draw_sprite_ext(
		sHealthBar,
		0,
		healthBarXOffset,
		healthBarYOffset,
		max(currentHealth/maxHealth,0),
		image_yscale,
		image_angle,
		image_blend,
		image_alpha
	);
	
	draw_sprite(sHealthBar,2,healthBarXOffset-5,healthBarYOffset);

	
	draw_set_font(fPixelTextMini);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	
	if(charaHP <= maxcharaHP/3.5) {
		
		healthText.textColor = c_white;
	}
	else {
		
		healthText.textColor = c_black;
	}
	
	healthText.textToDraw = charaHP;
}

function DrawKeyPressAlert() {
	
	var keyPressAlertX = x + sprite_width;
	var keyPressAlertY = y - sprite_height;
	
	keyPressAlertId = instance_create_layer(keyPressAlertX,keyPressAlertY,layer_get_id("layerGUI"),oEffect, {sprite_index: sKeyPress});
	
	return keyPressAlertId;
}

function DrawBuffMarker(baseDamage,currentDamage,baseDefense,currentDefense){
	
	var buffMarkerXOffset1 = x;
	var buffMarkerXOffset2 = buffMarkerXOffset1 - 8;
	var buffMarkerYOffset = y - sprite_height - 8;
	
	if(currentDamage > baseDamage){
		
		draw_sprite(sBuffMarker,0,buffMarkerXOffset1,buffMarkerYOffset);
		
	}
	else{
		
		if(currentDamage < baseDamage){
		
			draw_sprite(sBuffMarker,1,buffMarkerXOffset1,buffMarkerYOffset);
		
		}
	}
	
	if(currentDefense > baseDefense){
		
		draw_sprite(sBuffMarker,2,buffMarkerXOffset2,buffMarkerYOffset);
		
	}
	else{
		
		if(currentDefense < baseDefense){
		
			draw_sprite(sBuffMarker,3,buffMarkerXOffset2,buffMarkerYOffset);
		
		}
	}
}

function DrawBuffEfect(){
	instance_create_layer(x,y,layer_get_id("layerGUI"),oEffect,{sprite_index: sBuffEffect})
}

function DrawDeBuffEfect(){
		instance_create_layer(x,y,layer_get_id("layerGUI"),oEffect,{sprite_index: sDebuffEffect})
}

function DrawDefendEffect(){
	instance_create_layer(x,y,layer_get_id("layerGUI"),oEffect,{sprite_index: sDefendEffect});	
}

function DrawAlertEffect(){
	instance_create_layer(x,y,layer_get_id("layerGUI"),oEffect,{sprite_index: sAlertEffect});	
}

function DrawHealEffect(){
	instance_create_layer(x,y,layer_get_id("layerGUI"),oEffect,{sprite_index: sHealEffect});	
}

function DrawTextGlobe(textForGlobe) {
		
	instance_create_layer(x,y - sprite_height - sprite_get_height(sTextGlobe),layer_get_id("layerGUI"),oDialogueGlobe,{sprite_index: sTextGlobe , dialogueText: textForGlobe, dialogueGlobeText: noone});
	
}

function DrawSelectionArrow(){
	draw_sprite(sSelectionArrow,0,x,y - sprite_get_height(sprite_index));	
}