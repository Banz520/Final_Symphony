/// @description Progress Transition


if(leading == OUT){
	
	percent = min(1, percent + TRANSITION_SPEED);
	if(percent >= 1){//Si la pantalla ya se oscurecio
		
		room_goto(target);
		leading = IN;
		
	}
	
}
else{ //leading == IN

	percent = max(0, percent - TRANSITION_SPEED);
	if(percent <= 0){//Si la pantalla ya se oscurecio
		instance_destroy();
	}
}

