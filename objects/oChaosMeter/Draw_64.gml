/// @description Draw Battle Points and sprite w opacity 

if(!global.gamePaused && !instance_exists(oGame.gamePausedText)){
	
	var chaosMeterAlpha = min(1,0.7 + global.battlePoints/40);
	var chaosMeterColor = c_white;
	if(global.battlePoints <= 5){
		draw_sprite_ext(sChaosMeter,0,x,y,UI_XSCALE,UI_YSCALE,0,#ebebeb,chaosMeterAlpha);
	}
	else{
		if(global.battlePoints <= 10){
			if(floor(global.gameClock) % 5 == 0) chaosMeterColor = #ebebeb;
			draw_sprite_ext(sChaosMeter,1,x,y,UI_XSCALE,UI_YSCALE,0,chaosMeterColor,chaosMeterAlpha);	
		}
		else {
			var xToDraw = x + random_range((global.battlePoints * -1)/20,global.battlePoints/20);
			if(floor(global.gameClock) % 3 == 0) chaosMeterColor = #ebebeb;
			draw_sprite_ext(sChaosMeter,2,xToDraw,y,UI_XSCALE,UI_YSCALE,0,chaosMeterColor,chaosMeterAlpha);
		}
	} 
	
	var chaosMeterNumX = (x + chaosMeterSprWidthHalf -2) * UI_XSCALE;
	var chaosMeterNumY = (y + chaosMeterSprHeightHalf + 4) * UI_YSCALE;
	
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
