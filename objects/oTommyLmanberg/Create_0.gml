/// @description Player Set Up

// Inherit the parent event
event_inherited();

playerChooseTargetToSpecial = false;

//sprHurtListLength = array_length(sprHurt);


function PlayerStateAttack(){
	
	PlayerShotAttack(enemyTarget,PROYECTILE_SPR.ARROW,4,10,3);
	
}

function TommyLmanbergSpecial(){
	
	if(sprite_index != sprDefense){
		DeletePlayerActionMenu();
		localFrame = 0;
		sprite_index = sprDefense;	
	}
	
	AnimateSprite();
	flash = 0.5;
		
	if(animationEnd){
		// buff player charas
		for(var i = 0; i < global.playerCharasOnBattle;i++){
			
			var playerCharaToBuff = oBattleManager.playerCharasOnBattleList[|i];
			if(playerCharaToBuff != id){
				
				playerCharaToBuff.charaDefenseMod += BUFFMID;
				playerCharaToBuff.charaBuffDuration = 3;
				instance_create_layer(playerCharaToBuff.x,playerCharaToBuff.y,layer_get_id("layerGUI"),oEffect,{sprite_index: sBuffEffect})
			}
		}
		// debuff enemies
		for(var i = 0; i < global.enemiesOnBattle;i++){
			
			var enemyToDebuff = oBattleManager.enemiesOnBattleList[|i];
			if(enemyToDebuff != id){
				
				enemyToDebuff.charaDamageMod -= BUFFSMALL;
				enemyToDebuff.charaBuffDuration = 3;
				instance_create_layer(enemyToDebuff.x,enemyToDebuff.y,layer_get_id("layerGUI"),oEffect,{sprite_index: sDebuffEffect})
			}
		}
		
		instance_create_layer(x,y,layer_get_id("layerGUI"),oEffect,{sprite_index: sDebuffEffect})
		charaDefenseMod -= BUFFSMALL;
		charaBuffDuration = 3;
		
		charaState = charaStateWait;
	}
	
}


//Declare Character States
charaStateAttack = PlayerStateAttack; 
charaStateSpecial = TommyLmanbergSpecial;


buttonActionList = [
	[oButtonPlayerAttack,"Shot the selected enemy dealing\n"+string(charaDamageBase)+" points of damage!"],
	[oButtonPlayerDefend,defenseDesc],
	[oButtonPlayerSpecial,"TRADE DEFICIT: Rises the teammates defense\nbut decreases self"]
];

SetButtonList();