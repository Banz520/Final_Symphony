/// @description Insert description here
// You can write your code in this editor
AnimateSprite();
if(animationEnd)instance_destroy();



if(image_index > 3 && !instance_exists(dialogueGlobeText)){
	
	dialogueGlobeText = instance_create_layer(x + 14,y + 8, layer_get_id("layerGUI"),oText,{
		textToDraw: dialogueText,
		textColor: c_black,
		textFont: fPixelTextMicro,
		textHorizontalAlign: fa_center
	});
}

if(image_index >= 15 && instance_exists(dialogueGlobeText)){
	
	instance_destroy(dialogueGlobeText);
	dialogueGlobeText = noone;
}