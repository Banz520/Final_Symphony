/// @description Player States & Acts Set Up

// Inherit the parent event
event_inherited();

playerChooseTargetToSpecial = false;

//sprHurtListLength = array_length(sprHurt);


function TommyLmanbergAttack(){
	
	PlayerShotAttack(enemyTarget,PROYECTILE_SPR.ARROW,4,10,3);
	
}

function TommyLmanbergSpecial(){
	
	if(sprite_index != sprSpecial){
		DeletePlayerActionMenu();
		localFrame = 0;
		sprite_index = sprSpecial;	
	}
	
	AnimateSprite();
		
	if(animationEnd){
		
		//Heal allies
		PlayerHealAllTeammates();
		
		// buff player charas
		for(var i = 0; i < global.playerCharasOnBattle;i++){
			
			var playerCharaToBuff = oBattleManager.playerCharasOnBattleList[|i];
			if(playerCharaToBuff != id){
				
				playerCharaToBuff.charaDefenseMod += BUFFMID;
				playerCharaToBuff.charaBuffDuration = 3;
				playerCharaToBuff.DrawBuffEfect();
			}
		}
		// debuff enemies
		for(var i = 0; i < global.enemiesOnBattle;i++){
			
			var enemyToDebuff = oBattleManager.enemiesOnBattleList[|i];
			if(enemyToDebuff != id){
				
				enemyToDebuff.charaDamageMod -= BUFFSMALL;
				enemyToDebuff.charaBuffDuration = 3;
				enemyToDebuff.DrawDeBuffEfect();
			}
		}
		
		DrawDeBuffEfect();
		charaDefenseMod -= BUFFSMALL;
		charaBuffDuration = 3;
		
		charaState = charaStateWait;
	}
	
}


//Tommy interact relations
charasToInteractList = [

	["Dream","Tommy told Dream he's a green\ngoblin and how much he hates him\n-Dreams attack rose"],
	["Wilbur Lmanberg","Tommy tries to jump up to attack\n Dream but Wilbur stops him calling him\nwreckless"],
	["Tubbo Lmanberg","Tommy tells Tubbo this time they'll\nbeat Dream\n-Tommy and Tubbos attack rose"],
	["Sapnap","Tommy threathens Sapnap to kill Mars\nSapnap threathens to kill Henry\n-Tommy and Sapnaps attack rose"]

];

function PlayerInteractions(charaToInteractIndx, charaToInteractWith){
	
	
	switch(charaToInteractIndx){
			
		case 0:{
			//Dream
			charaToInteractWith.charaDamageMod += BUFFSMALL;	
			charaToInteractWith.DrawBuffEfect();
			charaToInteractWith.charaBuffDuration += 1;
			break;
		}
		
		case 1:{
			//Wilbur Lmanberg
			charaDamageMod -= BUFFSMALL;	
			DrawBuffEfect();
			break;
		}
		
		case 2:{
			//Tubbo Lmanberg
			charaToInteractWith.charaDamageMod += BUFFSMALL;	
			charaToInteractWith.DrawBuffEfect();
			charaDamageMod += BUFFSMALL;
			DrawBuffEfect();
			break;
		}
		
		case 3:{
			//Sapnap
			charaToInteractWith.charaDamageMod += BUFFSMALL;	
			charaToInteractWith.DrawBuffEfect();
			charaToInteractWith.charaBuffDuration += 1;
			charaDamageMod += BUFFSMALL;
			DrawBuffEfect();
			charaBuffDuration += 1;
			break;
		}
		
		default:{
			show_debug_message("The interaction lead to nothing");
			break;	
		}
	}
	
}


//Declare Character States
charaStateAttack = TommyLmanbergAttack; 
charaStateSpecial = TommyLmanbergSpecial;
//charaStateWait = PlayerStateWait;

tommySpecDesc = "TRADE DEFICIT: Heals allies and rises their defense\nbut decreases self and decreases enemy attack";

SetAtkValueToShootDesc();

buttonActionList = [
	[oButtonPlayerAttack,shotAtkDesc],
	[oButtonPlayerInteract,interactDesc],
	[oButtonPlayerDefend,defenseDesc],
	[oButtonPlayerSpecial,tommySpecDesc]
];

SetButtonList();

warningDialogue = "Careful!";

friendList = ["Tubbo","Wilbur"];

FindRelationCharasOnGame(friendList,oBattleManager.playerCharasOnBattleList,friendListOnLevel);

