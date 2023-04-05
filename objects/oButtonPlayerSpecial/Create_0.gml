/// @description Insert description here

// Inherit the parent event
event_inherited();

buttonSetAction = buttonPlayerCharaParent.charaStateAttack;
actionDescription = "Attack the selected enemy dealing\n"+string(buttonPlayerCharaParent.charaDamage)+" points of damage!\nCost: "+ string(buttonPlayerCharaParent.charaSpecialActCost) + " Chaos Points";