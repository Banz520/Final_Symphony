/// @description 

charaDamage = charaDamageBase * charaDamageMod;
charaHP = maxcharaHP;
charaState = -1;
charaDefenseMod = 1;
charaDefenseBase = charaDefense;
charaBuffDuration = 0;

flash = 0;
flashDecrease = 0.2;
flashShader = 0;

//Sprite Set Up
sprite_index = sprIdle;
image_speed = 0;
localFrame = 0;


//GUI Set Up

damageNumberXOffset = x+6;
damageNumberYOffset = y-sprite_height;

healthBarXOffset = round(x-sprite_get_width(sHealthBar)*0.5);
healthBarYOffset = round(y+4);

healthNumberX = healthBarXOffset + 7;
healthNumberY = healthBarYOffset + 2.25;

healthText = instance_create_layer(
				healthNumberX,
				healthNumberY,
				layer_get_id("layerGUI"),
				oText,
				{
					textToDraw: string(charaHP),
					textColor: c_black,
					textFont: fPixelTextMiniMicro
				}
			);


function CharaStateHurt(){
	
	if(sprite_index != sprHurt){
		sprite_index = sprHurt;
		localFrame = 0;
	}
	AnimateSprite(0.5);
		
	//screen shake
	hitScreenShake = true;
	if(hitScreenShake)ScreenShake(1.5,2);
	hitScreenShake = false;
	
	//flash
	flash = 0.5;
	flashShader = shWhiteFlash;
		
	//change state
	if(animationEnd)charaState = charaStateWait;
	
}

function CharaStateDead(){
	
	if(sprite_index != sprDead){
		sprite_index = sprDead;
		localFrame = 0;
	}
	AnimateSprite();
	if(animationEnd)instance_destroy();
	
}


//Declare Character States
charaStateWait = -1;
charaStateTurn = -1;
charaStateAttack = -1;
charaStateHurt = CharaStateHurt;
charaStateDead = CharaStateDead;
charaStateHeal = -1;
charaStateDefend = -1;
charaStateSpecial = -1;


function CreateHitMarker(targetToHit,dificulty = 0,spriteName,parentCharaid){
	
	if(instance_exists(targetToHit)){
			
		instance_create_layer(
			targetToHit.x,
			targetToHit.y-targetToHit.sprite_height*0.5,
			layer_get_id("layerGUI"),
			oHitMarker,
			{parentChara: parentCharaid,
			target: targetToHit,
			dificultySpeed: dificulty,
			image_speed: 0,
			sprite_index: spriteName
			}
		);
	}
}
	
function CreateHitParabProyectile(targetToHit,spd,attackByPlayer, proyectileSprite = 0){
	
	if(instance_exists(targetToHit)){
			
		instance_create_depth(
			x,
			y-other.sprite_height*0.6,
			depth-10,
			oParabolicProyectile,
			{charaDamage: other.charaDamage,
			target: targetToHit,
			vel: spd,
			parentChara: other.id,
			image_speed:0,
			image_index: proyectileSprite,
			attackComesFromPlayer: attackByPlayer
			}
		);
	}
	
}
	
function CreateHitLinearProyectile(targetToHit,spd,attackByPlayer,proyectileSprite = 0){
	
	if(instance_exists(targetToHit)){
			
		instance_create_depth(
			x,
			y-other.sprite_height*0.4,
			depth-10,
			oLinearProyectile,
			{charaDamage: other.charaDamage,
			target: targetToHit,
			vel: spd,
			parentChara: other.id,
			image_speed:0,
			image_index: proyectileSprite,
			attackComesFromPlayer: attackByPlayer
			}
		);
	}
	
	
}

function DrawHealthBar(maxHealth,currentHealth){
	
	//draw healthbar
	draw_sprite(sHealthBar,1,healthBarXOffset,healthBarYOffset);
	draw_sprite_ext(
		sHealthBar,
		0,
		healthBarXOffset,
		healthBarYOffset,
		max(currentHealth/maxHealth,0),
		image_yscale,
		image_angle,
		image_blend,
		image_alpha
	);
	draw_sprite(sHealthBar,2,healthBarXOffset-5,healthBarYOffset);
	
	
	
	draw_set_font(fPixelTextMini);
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	
	if(charaHP <= maxcharaHP/3.5)healthText.textColor = c_white;
	else healthText.textColor = c_black;
	healthText.textToDraw = charaHP;
	
}
