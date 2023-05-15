/// @description draw infoTextBox & animate
if(!global.gamePaused){
	if(deleteSelf == false){
	
		//expand anim
		if(image_xscale < 1 && image_yscale < 1){
			image_xscale += 0.08;
			image_yscale += 0.08;
		}
	
		//show action description
		if (selected){
	
			image_index = 1;
			image_xscale = 1;
			image_yscale = 1;
			x = floor(x);
			y = floor(y);
		
			//show description
			if(!instance_exists(descriptionBox)){
				descriptionBox = instance_create_layer(RES_WIDTH-8,8,layer_get_id("layerGUI"),oTextBox,{
					description: actionDescription,
					image_xscale: 0,
					xscaleRate: 0.5,
					imageHeight: RES_HEIGHT*0.25,
					showDesc: false,
					font: fPixelTextMiniMicro,
					textBoxWidth:RES_WIDTH*0.5
					
				});
			}
		
			if(executeAction) oBattleManager.currentPlayerCharaOnTurn.charaState = buttonSetAction;
		}
		else{ 
			image_index = 0;
			//Hide description
			if(instance_exists(descriptionBox))instance_destroy(descriptionBox);
		}
	}

	else{
		if(image_xscale >= 0 && image_yscale >= 0){
			image_xscale -= 0.08;
			image_yscale -= 0.08;
		}
		else{ 
		
			if(instance_exists(descriptionBox))instance_destroy(descriptionBox);
			instance_destroy();
		}
	}
}

