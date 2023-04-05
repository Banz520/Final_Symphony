/// @description sHealthBar & flash


DrawHealthBar(maxcharaHP,charaHP);

//draw flash
if(flash != 0){
		
	shader_set(flashShader);
	uFlash = shader_get_uniform(flashShader,"flash");
	shader_set_uniform_f(uFlash,flash);
		
}

//Draw Shadow
draw_sprite(sCharacterShadow,0,x,y);

//Draw Self
draw_sprite_ext(

		sprite_index,
		image_index,
		floor(x),
		floor(y),
		image_xscale,
		image_yscale,
		image_angle,
		image_blend,
		image_alpha

	);

if(shader_current() != -1) shader_reset();

