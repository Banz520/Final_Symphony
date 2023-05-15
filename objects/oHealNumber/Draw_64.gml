/// @description Draw Damage Number

draw_set_font(fPixelTextMini);
draw_set_halign(fa_center);
draw_set_valign(fa_center);
	
draw_set_color(c_green);
draw_text((x+1) * UI_XSCALE,(y-1) * UI_YSCALE,"+" + string(healTaken));
	
draw_set_color(c_white);
draw_text(x * UI_XSCALE,y * UI_YSCALE,"+" + string(healTaken));