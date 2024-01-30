/// @description Character States


// Inherit the parent event
event_inherited();

playerChooseTargetToAtk = false;
playerChooseTargetToHeal = false;

//sprHurtListLength = array_length(sprHurt);


function TubboLmanbergAttack(){
	
	PlayerSplashAttack(PROYECTILE_SPR.POTION,4,9,4);
		
}



function TubboLmanbergHeal(){
	
	if(sprite_index != sprHeal){
		DeletePlayerActionMenu();
		localFrame = 0;
		sprite_index = sprHeal;	
	}
	
	AnimateSprite();
	
	if(animationEnd){
		PlayerHealAllTeammates();
		charaState = charaStateWait;
	}
}


//Declare Character States
charaStateAttack = TubboLmanbergAttack; 
charaStateHeal = TubboLmanbergHeal;

tubboHealDescEN = "Heals " + string(charaRegen) + "HP to all teammates";
SetAtkValueToThrowDesc();



//Tubbo Interactions
charasToInteractList = [

	["Tommy","Tubbo gives Tommy a golden apple"]

];

function PlayerInteractions(charaToInteractIndx, charaToInteractWith){
	
	
	switch(charaToInteractIndx){
			
		case 0:{
			//Tommy
			charaToInteractWith.charaHP += 5;
			charaToInteractWith.DrawHealEffect();
			break;
		}
		
		default:{
			show_debug_message("The interaction lead to nothing");
			break;	
		}
	}
	
}


buttonActionList = [
	[oButtonPlayerAttack,throwAtkDesc],
	[oButtonPlayerInteract,interactDesc],
	[oButtonPlayerDefend,defenseDesc],
	[oButtonPlayerHeal,tubboHealDescEN]
];

SetButtonList();

friendList = ["Tommy","Eret"];
FindRelationCharasOnGame(friendList,oBattleManager.playerCharasOnBattleList,friendListOnLevel);

