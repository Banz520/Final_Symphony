/// @description Add bounce

if(bounceCount != 0){
	bounce += pi*0.1;
	if(bounce > pi){
		bounce -= pi;
		bounceHeight *= 0.2;
		bounceCount--;
	}
	y -= sin(bounce) * bounceHeight;
	x -= 0.3;
}
else{

	instance_destroy();
}
