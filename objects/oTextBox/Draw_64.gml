/// @description Insert description here
// You can write your code in this editor

if(showDesc){
	draw_set_font(font);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
	draw_set_color(c_white);
	draw_text((x-sprite_width+6) * UI_XSCALE,(y+2) * UI_YSCALE,string(description));
}

