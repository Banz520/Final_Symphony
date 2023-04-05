/// @description Reset enemySpawnList

// Clean up the dictionary when no longer needed
ds_map_destroy(perfectFrames);
ds_map_destroy(hitMarkSprList);

global.battlePoints = 0;
global.battleEnemySpawnList = [-1];
global.battlePlayerCharaSpawnList = [-1];
ds_list_destroy(enemiesOnBattleList);
ds_list_destroy(playerCharasOnBattleList);


