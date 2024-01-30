/// @description Fundy Move Set

// Inherit the parent event
event_inherited();

//FundySpec Mr President Son, if hit, all allies attack will rise


playerChooseTargetToAtk = true;

function FundyStateAttack() {
	
	
	PlayerHitAttack(6,sHitEffectSlash);
	
}

charaStateAttack = FundyStateAttack;
//charaStateWait = PlayerStateWait;
//Fundy Interactions
charasToInteractList = [

	["Wilbur","Fundy tells Wilbur to stop calling\n his little boy"]

];

function PlayerInteractions(charaToInteractIndx, charaToInteractWith){
	
	
	switch(charaToInteractIndx){
			
		case 0:{
			//Wilbur
			charaDefenseMod += BUFFSMALL;
			charaBuffDuration += 1;
			break;
		}
		
		default:{
			show_debug_message("The interaction lead to nothing");
			break;	
		}
	}
	
}


buttonActionList = [
	[oButtonPlayerAttack,hitAtkDesc],
	[oButtonPlayerInteract,interactDesc],
	[oButtonPlayerDefend,defenseDesc]
	
];

SetButtonList();


friendList = ["Wilbur"];

FindRelationCharasOnGame(friendList,oBattleManager.playerCharasOnBattleList,friendListOnLevel);
