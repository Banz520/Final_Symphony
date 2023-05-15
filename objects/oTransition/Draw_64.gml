/// @description Insert description here
// You can write your code in this editor


switch type{
	
	case TRANS_TYPE.CURTAIN: {
	
		draw_set_color(c_black);
		draw_rectangle(0,0,width,percent*(height),false);
		//dibujara un rectangulo negro desde la parte superior izquierda de la pantalla hasta el extremo derecho y lo ira bajando
		draw_rectangle(0,height,width,height-(percent*height),false);
	
		break;
	}
	
	case TRANS_TYPE.SIDESLIDE: {
		
		draw_set_color(c_black);
		draw_rectangle(0,0,percent*(width+50),height,false);
		
		break;
	}
	
	case TRANS_TYPE.FADE: {
		
		draw_set_color(c_black);
		draw_set_alpha(percent);
		draw_rectangle(0,0,width,height,false);
		
		if(leading == IN){
			
			draw_set_alpha(1);	
		}
		
		break;
	}
	
	
	default: break;
}



