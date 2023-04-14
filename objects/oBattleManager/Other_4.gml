/// @description Spawn enemies & maps



// Create the dictionary
perfectFrames = ds_map_create();

// Populate the dictionary with sprite indices and their corresponding perfect frames
ds_map_add(perfectFrames, sHitEffectStarPunch, 14);
ds_map_add(perfectFrames, sHitEffectShine, 1);
ds_map_add(perfectFrames, sHitEffectStar, 14);
ds_map_add(perfectFrames,sHitEffectSlash,10);


hitMarkSprList = ds_map_create();

ds_map_add(hitMarkSprList, 0, sHitEffectStar);
ds_map_add(hitMarkSprList, PROYECTILE_SPR.ARROW, sHitEffectShine);
ds_map_add(hitMarkSprList,PROYECTILE_SPR.POTION,sHitEffectSplash);

var backgroundLayer = layer_get_id("Background");
var battleBackground = layer_background_get_id(backgroundLayer);
layer_background_sprite(battleBackground, global.battleBackgroundSprite);

CreateEnemiesFromList();
CreatePlayerCharasFromList();

global.battlePoints = 0;

playerCharaOnTurnCount = 0
enemyOnTurnCount = 0;



