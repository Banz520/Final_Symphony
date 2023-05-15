/// @description Spawn enemies & maps



perfectFrames = ds_map_create();

// Melee
ds_map_add(perfectFrames, sHitEffectStarPunch, 14);
ds_map_add(perfectFrames, sHitEffectStar, 14);
ds_map_add(perfectFrames,sHitEffectSlash,10);
//Proyectiles
ds_map_add(perfectFrames, sHitEffectShine, 1);
ds_map_add(perfectFrames,sHitEffectSplash,100);
ds_map_add(perfectFrames,sHitEffectFire,100);

hitMarkSprList = ds_map_create();

ds_map_add(hitMarkSprList, PROYECTILE_SPR.FIREBALL, sHitEffectFire);
ds_map_add(hitMarkSprList, PROYECTILE_SPR.ARROW, sHitEffectShine);
ds_map_add(hitMarkSprList,PROYECTILE_SPR.POTION,sHitEffectSplash);

var backgroundLayer = layer_get_id("Background");
var battleBackground = layer_background_get_id(backgroundLayer);
layer_background_sprite(battleBackground, global.battleBackgroundSprite);

CreateEnemiesFromList();
CreatePlayerCharasFromList();

global.battlePoints = battlePointsInit + global.playerCharasOnBattle;

playerCharaTurns = global.playerCharasOnBattle-1;
enemyOnTurnCount = 0;



