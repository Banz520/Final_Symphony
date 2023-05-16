/// @description Insert description here
// You can write your code in this editor

instance_create_layer(
	RES_WIDTH * 0.5,
	RES_HEIGHT/3,
	layer_get_id("layerGUI"),
	oText,
	{
		textFont: fPixelTextMini,
		textColor: c_white,
		textToDraw: oGame.keyManual
	 }
);

enterToContinueText = noone;
configChangeText = noone;

