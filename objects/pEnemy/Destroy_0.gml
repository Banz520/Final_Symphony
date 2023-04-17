/// @description Lower Enemy Count

var deleteEnemy = ds_list_find_index(oBattleManager.enemiesOnBattleList,id);
ds_list_delete(oBattleManager.enemiesOnBattleList,deleteEnemy);

global.enemiesOnBattle--;
if(global.battlePoints < MAX_BATTLEPOINTS)global.battlePoints += 3;