/// @description STATE MACHINE UPDATE

if(!global.gamePaused){
	
	if(charaHP <= 0){
		charaState = charaStateDead;
		script_execute(charaStateDead);
		
	}
	else{
		
		script_execute(charaState);
		
	}
	flash = max(flash-flashDecrease,0);
	
}

