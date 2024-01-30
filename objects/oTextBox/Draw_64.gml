/// @description Insert description here
// You can write your code in this editor

if(showDesc){
	draw_set_font(font);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(textColor1);
	draw_text((x + 6) * UI_XSCALE,(y + 2) * UI_YSCALE,string(description1));
	
	if(hasSecondText){
		
		draw_set_font(font);
		draw_set_halign(fa_left);
		draw_set_valign(fa_top);
		draw_set_color(textColor2);
		draw_text((x + 6) * UI_XSCALE,(y + 2) * UI_YSCALE,string(description2));
	
	}
}

