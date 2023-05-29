/// @description Character States


// Inherit the parent event
event_inherited();

playerChooseTargetToAtk = false;
playerChooseTargetToSpecial = false;

//sprHurtListLength = array_length(sprHurt);


function PlayerStateAttack(){
	
	PlayerSplashAttack(PROYECTILE_SPR.POTION,4,9,4);
		
}



function TubboLmanbergHeal(){
	
	if(sprite_index != sprDefense){
		DeletePlayerActionMenu();
		localFrame = 0;
		sprite_index = sprDefense;	
	}
	
	AnimateSprite();
	
	if(animationEnd){
		PlayerHealAllTeammates();
		charaState = charaStateWait;
	}
}


//Declare Character States
charaStateAttack = PlayerStateAttack; 
charaStateHeal = TubboLmanbergHeal;


buttonActionList = [
	[oButtonPlayerAttack,"Attack all enemies dealing\n"+string(charaDamageBase)+" points of damage!"],
	[oButtonPlayerDefend,defenseDesc],
	[oButtonPlayerHeal,"Heals " + string(charaRegen) + "HP to all teammates"]
];

SetButtonList();