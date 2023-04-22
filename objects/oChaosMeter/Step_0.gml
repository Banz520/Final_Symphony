/// @description Insert description here
// You can write your code in this editor

if(global.battlePoints != prevBattlePoints){
	activateShake = true;
}
if(activateShake){
	if(chaosMeterShake > 0){
		
		//x += choose(-chaosMeterShake,chaosMeterShake);
		y += choose(-chaosMeterShake,chaosMeterShake);

		chaosMeterShake -= chaosMeterShake*0.7;
		
	}
	else{
		chaosMeterShake = 3;
		x = xOrigin;
		y = yOrigin;
		activateShake = false;
	}
}

prevBattlePoints = global.battlePoints;


