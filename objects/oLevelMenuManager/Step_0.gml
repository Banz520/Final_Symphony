/// @description Roll & select menu buttons

if(!global.gamePaused){
	currentLevelButtonSelected = SelectButtonWithKeys(levelButtonList);
	if(currentLevelButtonSelected != lastLevelButtonSelected ){
	
		var heightDifference = RES_HEIGHT*0.5 - currentLevelButtonSelected.y;
		
		for(var i = 0;i < levelSelectListLength;i++){
			levelButtonList[i].ogYPos += heightDifference;
			levelButtonList[i].yPosScaled += heightDifference;
		}
	}
	lastLevelButtonSelected = currentLevelButtonSelected;
}
backgroundMenu.sprite_index = currentLevelButtonSelected.levelBackgroundSprite;
 