/// @description Level Creation
// You can write your code in this editor
actionSelected = 0;
lastLevelButtonSelected = 0;

xOrigin = 20;
yOrigin = 20;

xSeparation = 0;
ySeparation = 15;

levelButtonXScale = 10;
levelButtonYScale = 2;

arrowsXOrigin = (xOrigin + xSeparation + levelButtonXScale * sprite_get_width(sLevelSelectorButton)) * UI_XSCALE;
arrowsYOrigin = RES_HEIGHT * 0.5 * UI_YSCALE;

arrowImage = 1;

//Add here each level configuration
levelSelectorList = [

	["Lmanberg - Independance War",LEVELSELECT_SPRITE.LMANBERG_OUTLINE,sBackGroundLmanbergDay,[oEnemyDream,oEnemySnapnap,oEnemyGeorge,oEnemyPunz],[oWilburLmanberg,oTommyLmanberg,oTubboLmanberg,oTheEretLmanberg],0,sqComicLmanberg1],
	["Lmanberg - Meant To Be",LEVELSELECT_SPRITE.LMANBERG_OUTLINE,sBackGroundFinalControlRoom,[oEnemyDream,oEnemyPunz,oEnemySnapnap,oEnemyEret],[oWilburLmanberg,oTubboLmanberg,oFundyLmanberg,oTommyLmanberg],0,sqComicEmpty],
	["Lmanberg - Final Duet",LEVELSELECT_SPRITE.LMANBERG_OUTLINE,sBackGroundLmanberg,[oEnemyDream],[oTommyLmanberg],1,sqComicEmpty],
	["Manberg - The Elections",LEVELSELECT_SPRITE.RED_OUTLINE,sBackGroundManberg,[oEnemySchlatt,oEnemyQuackityManberg,oEnemyGeorge,oEnemyPunz],[oWilburLmanberg,oTommyLmanberg],0,sqComicEmpty],
	["Manberg - Red Festival",LEVELSELECT_SPRITE.RED_OUTLINE,sBackGroundManbergFestival,[oEnemyQuackityManberg,oEnemyTubboManberg,oEnemySchlatt],[oWilburPogtopia,oTechnoBlade],1,sqComicEmpty],
];

levelSelectListLength = array_length(levelSelectorList);
levelButtonList = [-1];

for(var i = 0; i < levelSelectListLength; i++){
		
		levelButtonList[i] = instance_create_depth(
			xOrigin + xSeparation,
			yOrigin + ySeparation * i + sprite_get_height(sLevelSelectorButton) * levelButtonYScale * i,
			depth,
			oLevelSelector,
			{	
				image_xscale: levelButtonXScale,
				image_yscale: levelButtonYScale,
				levelDesc: levelSelectorList[i][0],
				image_index: levelSelectorList[i][1],
				levelBackgroundSprite: levelSelectorList[i][2],
				levelEnemyList: levelSelectorList[i][3],
				levelPlayerCharasList: levelSelectorList[i][4],
				levelSpawnDistance: levelSelectorList[i][5],
				levelComic: levelSelectorList[i][6],
				
				//numberID: i
			}
		);	
}
	
backgroundMenu = instance_create_depth(0,0,depth + 10,oBackgroundMenu,{sprite_index: levelSelectorList[0][2], image_alpha: 0.1});

