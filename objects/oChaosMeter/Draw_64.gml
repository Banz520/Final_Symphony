/// @description Draw Battle Points and sprite w opacity 

if(!global.gamePaused && !instance_exists(oTransition)){
	draw_sprite_ext(sChaosMeter,0,x,y,UI_XSCALE,UI_YSCALE,0,c_white,0.5+(global.battlePoints*10)/200);

	var chaosMeterNumX = (x + chaosMeterSprWidthHalf - 2) * UI_XSCALE;
	var chaosMeterNumY = (y + chaosMeterSprHeightHalf - 4) * UI_YSCALE;
	
	draw_set_font(fPixelTextMini);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);

	draw_set_color(c_red);
	draw_text(chaosMeterNumX,chaosMeterNumY + 3,string(global.battlePoints));
	draw_text(chaosMeterNumX,chaosMeterNumY - 3,string(global.battlePoints));
	draw_text(chaosMeterNumX + 3,chaosMeterNumY,string(global.battlePoints));
	draw_text(chaosMeterNumX - 3,chaosMeterNumY,string(global.battlePoints));
	
	draw_set_color(c_white);
	draw_text(chaosMeterNumX,chaosMeterNumY,string(global.battlePoints));
}
