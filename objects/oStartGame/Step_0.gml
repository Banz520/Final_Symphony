/// @description Insert description here
// You can write your code in this editor




if(global.gameClock > 15){

	if(configChangeText == noone){
		configChangeText = instance_create_layer(
			RES_WIDTH * 0.5,
			RES_HEIGHT - RES_HEIGHT/8,
			layer_get_id("layerGUI"),
			oText,
			{
				textFont: fPixelTextMicro,
				textColor: c_ltgray,
				textToDraw: "(You can change the game LANGUAGE\nand KEYBINDS on the config menu)"
			 }
		);
	}
}


if(global.gameClock > 28){
	
	if(enterToContinueText == noone){
		instance_create_layer(
			RES_WIDTH * 0.5,
			RES_HEIGHT - RES_HEIGHT/3,
			layer_get_id("layerGUI"),
			oText,
			{
				textFont: fPixelTextMini,
				textColor: c_yellow,
				textToDraw: "[PRESS SPACE TO CONTINUE...]"
			 }
		);
	}
	
}


