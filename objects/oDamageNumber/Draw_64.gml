/// @description Draw Damage Number

draw_set_font(fPixelTextMini);
draw_set_halign(fa_center);
draw_set_valign(fa_center);

draw_set_color(c_red);
draw_text((x+1)*2,(y-1)*2,string(damageTaken));

draw_set_color(c_white);
draw_text(x*2,y*2,string(damageTaken));