
function RoomTransition(transType,transTargetRoom){

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

function SelectEnemyWithKeys(){
	
	//Select enemy to interact with
		var keySelectLeft = (keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left) || keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up))*-1;
		var keySelectRight = (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right) || keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down));
			
		//keep selection on the enemy list number range
		if(enemySelected <= (global.enemiesOnBattle-1) && enemySelected >= 0){
			enemySelected += keySelectLeft+keySelectRight;
		}
		else{
			if(enemySelected > (global.enemiesOnBattle-1)){
				enemySelected = 0;
			}
			else if(enemySelected < 0){
				enemySelected = (global.enemiesOnBattle-1);
			}
		}//keep selection on the enemy list number range
				
		enemyTarget = oBattleManager.enemiesOnBattleList[|enemySelected];	
		with(enemyTarget) flash = 0.5;
		return enemyTarget;
}

function SelectButtonWithKeys(buttonList){
	
	
	//Select action to perform
		var keySelectUp = (keyboard_check_pressed(ord("W")) || keyboard_check_pressed(vk_up) || keyboard_check_pressed(ord("A")) || keyboard_check_pressed(vk_left))*-1 ;
		var keySelectDown = (keyboard_check_pressed(ord("S")) || keyboard_check_pressed(vk_down)) || (keyboard_check_pressed(ord("D")) || keyboard_check_pressed(vk_right));
			
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
	
function DrawHealthBar(maxHealth,currentHealth){
	
	//draw healthbar
	draw_sprite(sHealthBar,1,healthBarXOffset,healthBarYOffset);
	draw_sprite_ext(
		sHealthBar,
		0,
		healthBarXOffset,
		healthBarYOffset,
		max(currentHealth/maxHealth,0),
		image_yscale,
		image_angle,
		image_blend,
		image_alpha
	);
	
}


	