/// @description STATE MACHINE UPDATE

if(!global.gamePaused){
	
	if(charaHP <= 0){
		charaState = charaStateDead;
		script_execute(charaStateDead);
		
	}
	else{
		charaDamage =  charaDamageBase * min(charaDamageMod,2);
		charaDefense = charaDefenseBase * min(charaDefenseMod,2);
		if(charaHP > maxcharaHP)charaHP = maxcharaHP;
		script_execute(charaState);
	
	}
	flash = max(flash-flashDecrease,0);
	
}


