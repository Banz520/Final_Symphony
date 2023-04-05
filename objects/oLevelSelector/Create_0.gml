/// @description 

levelEnemyListCopy = [-1];
var levelEnemyListLength = array_length(levelEnemyList);
array_copy(levelEnemyListCopy,0,levelEnemyList,0,levelEnemyListLength);

levelPlayerCharasListCopy = [-1];
var levelPlayerCharaListLength = array_length(levelPlayerCharasList);
array_copy(levelPlayerCharasListCopy,0,levelPlayerCharasList,0,levelPlayerCharaListLength);

ogXScale = image_xscale;
ogYScale = image_yscale;

selected = false;

ogXPos = x;
ogYPos = y;

scaleXPercentage = 0.5;
scaleYPercentage = 0.5;

//restar la mitad escalada a la original y eso restarselo a la posicion para que los centros coincidan
xPosScaled = floor(x-(((sprite_width/ogXScale)*(ogXScale+scaleXPercentage)*0.5)-((sprite_width/ogXScale)*ogXScale*0.5)));
yPosScaled = floor(y-(((sprite_height/ogYScale)*(ogYScale+scaleYPercentage)*0.5)-((sprite_height/ogYScale)*ogYScale*0.5)));