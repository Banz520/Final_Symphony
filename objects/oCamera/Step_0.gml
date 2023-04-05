/// @description Screen Shake


//Keep Camera Inside Room
x = clamp(x,viewWidthHalf,room_width-viewWidthHalf);
//clamp mantiene el primer parametro dentro del rango de los otros
y = clamp(y,viewHeightHalf,room_height-viewHeightHalf);


//Screen Shake
x += random_range(-shakeRemain,shakeRemain);
y += random_range(-shakeRemain,shakeRemain);

shakeRemain = max(0,shakeRemain - ((1/shakeLength) * shakeMagnitude));

camera_set_view_pos(cam,x - viewWidthHalf, y - viewHeightHalf);
