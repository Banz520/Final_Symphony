/// @description Lower Enemy Count
event_inherited();

var deleteEnemy = ds_list_find_index(oBattleManager.enemiesOnBattleList,id);
ds_list_delete(oBattleManager.enemiesOnBattleList,deleteEnemy);

global.enemiesOnBattle--;
if(global.battlePoints < MAX_BATTLEPOINTS)global.battlePoints += global.battlePointsForEnemyDefeat;