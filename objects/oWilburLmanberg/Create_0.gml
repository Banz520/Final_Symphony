/// @description Player Set Up

// Inherit the parent event
event_inherited();

playerChooseTargetToHeal = false;
playerChooseTargetToSpecial = false;

//sprHurtListLength = array_length(sprHurt);


function WilburLmanbergBuff(){
	
	if(sprite_index != sprHeal){
		DeletePlayerActionMenu();
		localFrame = 0;
		sprite_index = sprHeal;	
	}
	
	AnimateSprite();
	
	if(animationEnd){
		for(var i = 0; i < global.playerCharasOnBattle;i++){
			
			var playerCharaToBuff = oBattleManager.playerCharasOnBattleList[|i];
			playerCharaToBuff.charaDamageMod += BUFFMID;
			playerCharaToBuff.charaDefenseMod += BUFFMID;
			playerCharaToBuff.charaBuffDuration = 2;
			
			playerCharaToBuff.DrawBuffEfect();
		
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
			
			enemyToTaunt.DrawAlertEffect();
			
		}
		charaState = charaStateWait;
	}
}


//Declare Character States
charaStateHeal = WilburLmanbergBuff;   
charaStateSpecial = WilburLmanbergSpecial;


wilburLmanbergBuffDescEN = "Rises all allies defense and damage by 2 pts";
wilburLmanbergSpecDescEN = "Wilbur becomes the main target to all enemies";

wilburLmanbergBuffDesc = wilburLmanbergBuffDescEN;
wilburLmanbergSpecDesc = wilburLmanbergSpecDescEN;

charasToInteractList = [

	["Dream","Wilbur teased Dream"],
	["George","Wilbur glared at George\n-Wilbur let his defense drop"],
	["Tommy Lmanberg","Wilbur tries to keep Tommy\nfrom rushing into the battle\nTommy becomes impatient\n-Tommys attack rose"],
	["Quackity Manberg","Wilbur calls out to Quackity telling him\nhe's not strong enough to be a leader"],
	["Schlatt","Wilbur calls Schlatt a tyrant, he doesn't\nseem to care..."]
];


function PlayerInteractions(charaToInteractIndx, charaToInteractWith){
	
	
	switch(charaToInteractIndx){
			
		case 0:{
			//Dream
			charaToInteractWith.charaDefenseMod -= BUFFMID;	
			charaToInteractWith.DrawDeBuffEfect();
			break;
		}
		
		case 1:{
			//George
			charaDefenseMod -= BUFFMID;	
			DrawDeBuffEfect();
			break;
		}
		
		case 2:{
			//Tommy Lmanberg
			charaToInteractWith.charaDamageMod += BUFFMID;	
			charaToInteractWith.DrawBuffEfect();
			break;
		}
		
		case 3:{
			//Quackity Manberg
			CreateHitMarker(charaToInteractWith,1,sHitEffectAngry,id,8);
			break;
		}
		
		case 4:{
			//Schlatt
			//CreateHitMarker(charaToInteractWith,1,sHitEffectAngry,id,charaDamage);
			break;
		}
		
		default:{
			show_debug_message("The interaction lead to nothing");
			break;	
		}
	}
	
}

buttonActionList = [
	[oButtonPlayerBuff,wilburLmanbergBuffDesc],
	[oButtonPlayerInteract,interactDesc],
	[oButtonPlayerDefend,defenseDesc],
	[oButtonPlayerSpecial,wilburLmanbergSpecDesc]
];

SetButtonList();