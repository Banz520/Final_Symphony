/// @description Eret MoveSet
// Inherit the parent event
event_inherited();

playerChooseTargetToAtk = true;
playerChooseTargetToSpecial = false;


function EretStateAttack(){
		
	PlayerHitAttack(12,sHitEffectSlash);
}

function EretSpecial(){
	
	if(sprite_index != sprSpecial){
		DeletePlayerActionMenu();
		localFrame = 0;
		sprite_index = sprSpecial;
		
		
	}
	
	AnimateSprite();
	
	if(animationEnd){
		
		for(var i = 0; i < global.playerCharasOnBattle; i++){
			
			var playerCharaToBetray = oBattleManager.playerCharasOnBattleList[|i];
			if(playerCharaToBetray != id)CreateHitMarker(playerCharaToBetray,2,sHitEffectSlash,id);
			
		}
		
		DrawBuffEfect();
		charaDamageMod += BUFFBIG;
		charaDefenseMod += BUFFBIG;
		charaBuffDuration = 3;
		
		charaState = charaStateWait;
	}
}



charaStateAttack = EretStateAttack;
charaStateSpecial = EretSpecial;

buttonActionList = [
	[oButtonPlayerAttack,hitAtkDesc],
	[oButtonPlayerDefend,defenseDesc],
	[oButtonPlayerSpecial,string("MEANT TO BE: Eret betrays their allies dealing\n{0} points of damage to them but rises Erets\ndefense and attack a lot!",charaDamage)]
];

SetButtonList();