
function RoomTransition(transType = TRANS_TYPE.FADE,transTargetRoom = rBattle){

	if(!instance_exists(oTransition)){
		
		instance_create_depth(0,0,-999,oTransition,{type: transType, target: transTargetRoom})
			
	}else show_debug_message("Trying to transition while transition is happening");

}

function AnimateSprite(animSpeed = 0){
	
	var _totalFrames = sprite_get_number(sprite_index);
	
	image_index = localFrame;
	
	localFrame += ((sprite_get_speed(sprite_index) / FRAME_RATE) + (animSpeed/10));
	//esto delimita al sprite a animarse solo lo que el frame rate permita 
	
	
	//Reinicia la animacion y marca si esta termino 
	if (localFrame >= _totalFrames){
		animationEnd = true;
		localFrame -= _totalFrames;
	}else animationEnd =  false;
	
}
	
function ScreenShake(magnitude,frames){

	with(global.iCamera){
		
		if(magnitude > shakeRemain){
			//solo se ejecutara el shake mayor
			shakeMagnitude = magnitude;
			shakeRemain = shakeMagnitude;
			shakeLength = frames;
		}
	}

}

function SelectButtonWithKeys(buttonList){
	
	
	//Select action to perform
		var keySelectUp = (global.keyPrevLeft || global.keyNextUp)*-1 ;
		var keySelectDown = (global.keyNextRight|| global.keyPrevDown);
			
		buttonList[actionSelected].selected = true;
		var lastActionSelected = actionSelected;
		
		//keep selection on the button array number range
		if(actionSelected <= array_length(buttonList)-1 && actionSelected >= 0){
			actionSelected += keySelectUp+keySelectDown;
			if(actionSelected > array_length(buttonList)-1){
				actionSelected = 0;
			}
			else if(actionSelected < 0){
				actionSelected = array_length(buttonList)-1;
			}
		}
		else{
			if(actionSelected > array_length(buttonList)-1){
				actionSelected = 0;
			}
			else if(actionSelected < 0){
				actionSelected = array_length(buttonList)-1;
			}
		}//keep selection on the button array number range
		if(lastActionSelected != actionSelected)buttonList[lastActionSelected].selected = false;
		
		return buttonList[actionSelected];			
}


	