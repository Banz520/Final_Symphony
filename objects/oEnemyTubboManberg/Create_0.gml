/// @description 

// Inherit the parent event
event_inherited();

sprIdle = sTubboManbergIdle;
sprHurt = sTubboLmanbrgHurt;
sprHeal = sTubboManbergHeal;
sprDead = sprHurt;


function EnemyTubboManbergTurn(){
		
	if(sprite_index != sprIdle)sprite_index = sprIdle;
	
	AnimateSprite();
		
	//Enemy AI here
	charaState = charaStateHeal;
}

function EnemyTubboManbergHeal(){
	
	if(sprite_index != sprHeal){
		sprite_index = sprHeal;
		localFrame = 0;
	}
	
	AnimateSprite();
	
	if(floor(localFrame) == 5){
		DrawTextGlobe("Let the fes\ntival begin!");
	}
	
	if(animationEnd){
		
		var enemyToHeal = FindLVPChara(global.enemiesOnBattle, oBattleManager.enemiesOnBattleList);
		
		enemyToHeal.DrawHealEffect();
		enemyToHeal.charaHP += 6;
		
		charaState = charaStateWait;
	}
}

charaStateTurn = EnemyTubboManbergTurn;
charaStateHeal = EnemyTubboManbergHeal;

charaState = charaStateWait;