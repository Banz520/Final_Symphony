/// @description Set Description
// Inherit the parent event
event_inherited();
buttonSetAction = buttonPlayerCharaParent.charaStateHeal;
actionDescription = string(actionDescription) + "\nCost: " + string(buttonPlayerCharaParent.charaHealCost) + " Chaos Points";