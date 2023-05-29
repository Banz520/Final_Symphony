/// @description Player Set Up

// Inherit the parent event
event_inherited();

playerChooseTargetToHeal = false;
playerChooseTargetToSpecial = false;

//sprHurtListLength = array_length(sprHurt);


function PlayerStateHeal(){
	
	if(sprite_index != sprSpecial){
		DeletePlayerActionMenu();
		localFrame = 0;
		sprite_index = sprSpecial;	
	}
	
	AnimateSprite();
	
	if(animationEnd){
		for(var i = 0; i < global.playerCharasOnBattle;i++){
			
			var playerCharaToBuff = oBattleManager.playerCharasOnBattleList[|i];
			playerCharaToBuff.charaDamageMod += BUFFSMALL;
			playerCharaToBuff.charaDefenseMod += BUFFSMALL;
			playerCharaToBuff.charaBuffDuration = 1;
			
			instance_create_layer(playerCharaToBuff.x,playerCharaToBuff.y,	layer_get_id("layerGUI"),oEffect,{sprite_index: sBuffEffect})
		
		}
		charaState = charaStateWait;
	}
}

function WilburLmanbergSpecial(){
	
	if(sprite_index != sprSpecial){
		DeletePlayerActionMenu();
		localFrame = 0;
		sprite_index = sprSpecial;	
	}
	
	AnimateSprite();
	
	if(animationEnd){
		
		for(var i = 0; i < global.enemiesOnBattle; i++){
		
			var enemyToTaunt = oBattleManager.enemiesOnBattleList[|i];
			enemyToTaunt.enemyTauntTarget = id;
			enemyToTaunt.enemyTauntDuration = 2;
			
			instance_create_layer(
				enemyToTaunt.x,
				enemyToTaunt.y,
				layer_get_id("layerGUI"),
				oEffect,
				{sprite_index: sAlertEffect}
			);
		}
		charaState = charaStateWait;
	}
}


//Declare Character States
charaStateHeal = PlayerStateHeal;   
charaStateSpecial = WilburLmanbergSpecial;


buttonActionList = [
	[oButtonPlayerHeal,"Rises all allies defense and damage"],
	[oButtonPlayerDefend,defenseDesc],
	[oButtonPlayerSpecial,"Wilbur becomes the main target to all\nenemies"]
];

SetButtonList();