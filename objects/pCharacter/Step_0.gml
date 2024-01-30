/// @description STATE MACHINE UPDATE

if(!global.gamePaused){
	
	if(charaHP <= 0){
		charaState = charaStateDead;
		script_execute(charaStateDead);
		
	}
	else{
		
		//charaDamage =  charaDamageBase * min(charaDamageMod,2);
		//charaDefense = charaDefenseBase * min(charaDefenseMod,2);
		
		//Limit charaDamageMod and charaDefenseMod
		if(charaDamageMod > 5) charaDamageMod = 5;
		if(charaDefenseMod > 5) charaDefenseMod = 5;
		
		//Get Damage Value
		if(charaDamagePrev != charaDamageBase + charaDamageMod){
			
			charaDamage = charaDamageBase + charaDamageMod;
			charaDamagePrev = charaDamage;
		}
		
		//Get Defense Value
		if(charaDefensePrev != charaDefenseBase + charaDefenseMod){
			
			charaDefense = charaDefenseBase + charaDefenseMod;
			charaDefensePrev = charaDefense;
		}
		
		if(charaHP > maxcharaHP)charaHP = maxcharaHP;
		
		script_execute(charaState);
	
	}
	flash = max(flash-flashDecrease,0);
	
}


