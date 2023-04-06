/// @description Remove PlayerChara from lists and counts

var deletePlayerChara = ds_list_find_index(oBattleManager.playerCharasOnBattleList,id);
ds_list_delete(oBattleManager.playerCharasOnBattleList,deletePlayerChara);

global.playerCharasOnBattle--;

