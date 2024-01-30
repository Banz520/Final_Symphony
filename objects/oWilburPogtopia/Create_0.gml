/// @description Character States


// Inherit the parent event
event_inherited();

playerChooseTargetToAtk = false;

sprDead = sWilburPogtopiaDead;
sprHurt = sWilburPogtopiaHurt;

//sprHurtListLength = array_length(sprHurt);


function WilburPogtopiaAttack(){
	
	PlayerSplashAttack(PROYECTILE_SPR.TNT,4,24,19);
		
}

function WilburPogtopiaDead() {
	
	if(sprite_index != sprDead){
		sprite_index = sprDead;
		localFrame = 0;
		
		DrawTextGlobe(" It was never\nmeant to be");
	}
	
	AnimateSprite();
	
	if(animationEnd){
		
		for(var playerCharasToExplode = 0; playerCharasToExplode < global.playerCharasOnBattle; playerCharasToExplode++){
			
			var playerCharaToExplodeId = oBattleManager.playerCharasOnBattleList[|playerCharasToExplode];
			
			if(playerCharaToExplodeId != id){
				CreateHitMarker(playerCharaToExplodeId,1,sHitEffectExplosion,id);
			}
		}
		
		for(var enemiesToExplode = 0; enemiesToExplode < global.enemiesOnBattle; enemiesToExplode++){
			
			var enemyToExplodeId = oBattleManager.enemiesOnBattleList[|enemiesToExplode];
			
			CreateHitMarker(enemyToExplodeId,1,sHitEffectExplosion,id);
		}
		
		instance_destroy();
	}
}


//Declare Character States
charaStateAttack = WilburPogtopiaAttack; 
charaStateDead = WilburPogtopiaDead;

SetAtkValueToThrowDesc();



//Tubbo Interactions
charasToInteractList = [

	["Tommy","Wilbur tells Tommy they wont get\n Lmanberg back!"]

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
	[oButtonPlayerDefend,defenseDesc]
	
];

SetButtonList();

friendList = ["Tommy","Technoblade"];
FindRelationCharasOnGame(friendList,oBattleManager.playerCharasOnBattleList,friendListOnLevel);

