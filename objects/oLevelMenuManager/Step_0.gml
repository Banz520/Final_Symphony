/// @description Roll & select menu buttons

if(!global.gamePaused){
	
	currentLevelButtonSelected = SelectButtonWithKeys(levelButtonList);
	
	if(currentLevelButtonSelected != lastLevelButtonSelected ){
		
		var heightDifference = RES_HEIGHT * 0.5 - currentLevelButtonSelected.y;
		
		for(var i = 0;i < levelSelectListLength;i++){
			levelButtonList[i].ogYPos += heightDifference;
			levelButtonList[i].yPosScaled += heightDifference;
		}
	}
	lastLevelButtonSelected = currentLevelButtonSelected;
	
	if(keyboard_check(vk_up)){
		arrowImage = 2;
		arrowTimerInnit = get_timer() / 1000;
		//show_debug_message(timeWhenChanged);
	}
	
	if(keyboard_check(vk_down)){
		arrowImage = 0;
		arrowTimerInnit = get_timer() / 1000;
		//show_debug_message(timeWhenChanged);
	}
	
	if(arrowImage != 1){
		var arrowDeltaTime = (get_timer() / 1000) - arrowTimerInnit;
		if(arrowDeltaTime > 200) arrowImage = 1;
	}
}

backgroundMenu.sprite_index = currentLevelButtonSelected.levelBackgroundSprite;
 