/// @description 

maxcharaHP = charaHP;
charaState = -1;

flash = 0;
flashDecrease = 0.2;
flashShader = 0;

//Sprite Set Up
sprite_index = sprIdle;
image_speed = 0;
localFrame = 0;


//GUI Set Up
healthBarXOffset = -1;
healthBarYOffset = -1;

damageNumberXOffset = -1;
damageNumberYOffset = -1;


//Declare Character States
charaStateWait = -1;
charaStateTurn = -1;
charaStateAttack = -1;
charaStateHurt = -1;
charaStateDead = -1;
charaStateHeal = -1;
charaStateDefend = -1;
charaStateSpecial = -1;


function CreateHitMarker(targetToHit,dificulty = 0,spriteName,originDamage = other.charaDamage){
	
	if(instance_exists(targetToHit)){
			
		instance_create_layer(
			targetToHit.x,
			targetToHit.y-targetToHit.sprite_height*0.5,
			layer_get_id("layerGUI"),
			oHitMarker,
			{damage: originDamage,
			target: targetToHit,
			dificultySpeed: dificulty,
			image_speed: 0,
			sprite_index: spriteName
			}
		);
	}
}
	
function CreateHitProyectile(targetToHit,spd, proyectileSprite = 0){
	
	if(instance_exists(targetToHit)){
			
		instance_create_depth(
			x,
			y-other.sprite_height*0.4,
			depth-10,
			oParabolicProyectile,
			{charaDamage: other.charaDamage,
			target: targetToHit,
			vel: spd,
			parentChara: other.id,
			image_speed:0,
			image_index: proyectileSprite
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
	
}
