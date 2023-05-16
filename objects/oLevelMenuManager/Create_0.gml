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

//Add here each level configuration
levelSelectorList = [

	["Lmanberg - Ode to Lmanberg\nIndependance War",LEVELSELECT_SPRITE.LMANBERG_OUTLINE,sBackGroundLmanbergDay,[oEnemyDream,oEnemySnapnap,oEnemyGeorge,oEnemyPunz],[oWilburLmanberg,oTommyLmanberg,oTubboLmanberg,oTheEretLmanberg],0,sqComicLmanberg1],
	["Lmanberg - FINAL SYMPHONY\nTommy vs Dream Duel",LEVELSELECT_SPRITE.LMANBERG_OUTLINE,sBackGroundLmanberg,[oEnemyDream],[oTommyLmanberg],1,sComicLmanberg1],
	["Manberg Festival part 1",LEVELSELECT_SPRITE.LMANBERG_OUTLINE,sBackGroundManberg,[oEnemyDream,oEnemyGeorge],[oWilburLmanberg,oTommyLmanberg],1,sComicLmanberg1],
	
];

levelSelectListLength = array_length(levelSelectorList);
levelButtonList = [-1];

for(var i = 0; i < levelSelectListLength; i++){
		
		levelButtonList[i] = instance_create_depth(
			xOrigin + xSeparation,
			yOrigin + ySeparation*i + oLevelSelector*levelButtonYScale*i,
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
				levelComic: levelSelectorList[i][6]
				
			}
		);	
}
	
backgroundMenu = instance_create_depth(0,0,depth+10,oBackgroundMenu,{sprite_index: levelSelectorList[0][2], image_alpha: 0.1});

