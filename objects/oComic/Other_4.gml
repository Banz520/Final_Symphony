/// @description Insert description here
// You can write your code in this editor

comicSequence = layer_sequence_create(layer_get_id("layerGUI"),x,y,global.comic);

instance_create_layer(RES_WIDTH - 35, RES_HEIGHT - 10,layer_get_id("layerGUI"),oText,{textToDraw: "Press SPACE to skip...", textColor: c_dkgray, textFont: fPixelTextMiniMicro, textHorizontalAlign: fa_center});