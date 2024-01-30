/// @description key Manual at start
// You can write your code in this editor

instance_create_layer(
	RES_WIDTH * 0.25,
	RES_HEIGHT/4,
	layer_get_id("layerGUI"),
	oText,
	{
		textFont: fPixelTextMini,
		textColor: c_white,
		textToDraw: oGame.keyManual,
		textHorizontalAlign: fa_left
	 }
);

instance_create_layer(
			RES_WIDTH * 0.5,
			RES_HEIGHT * 0.5 + 8,
			layer_get_id("layerGUI"),
			oEffect,
			{
				sprite_index:	sKeyBoardUse
				
			}
		);

enterToContinueText = noone;
//configChangeText = noone;

textTimerInnit = get_timer() / 1000;