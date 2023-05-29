/// @description 
// Inherit the parent event
event_inherited();

playerChooseTargetToAtk = true;
playerChooseTargetToSpecial = false;


function PlayerStateAttack(){
		
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
		
		instance_create_layer(x,y,layer_get_id("layerGUI"),oEffect,{sprite_index: sBuffEffect});
		charaDamageMod += BUFFBIG;
		charaDefenseMod += BUFFBIG;
		charaBuffDuration = 3;
		
		charaState = charaStateWait;
	}
}



charaStateAttack = PlayerStateAttack;
charaStateSpecial = EretSpecial;

buttonActionList = [
	[oButtonPlayerAttack,"Attacks enemy"],
	[oButtonPlayerDefend,defenseDesc],
	[oButtonPlayerSpecial,string("MEANT TO BE: Eret betrays their allies dealing\n{0} points of damage to them but rises Erets\ndefense and attack a lot!",charaDamage)]
];

SetButtonList();