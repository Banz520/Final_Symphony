/// @description Draw Battle Points and sprite w opacity 

if(!global.gamePaused){
	draw_sprite_ext(sChaosMeter,0,x,y,2,2,0,c_white,0.5+(global.battlePoints*10)/200);

	draw_set_font(fPixelTextMini);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);

	draw_set_color(c_red);
	draw_text((x+18)*2,(y+18)*2,string(global.battlePoints));

	draw_set_color(c_white);
	draw_text((x+17)*2,(y+17)*2,string(global.battlePoints));
}
