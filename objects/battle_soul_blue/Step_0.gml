event_inherited();

switch(dir){
	case 0:
	  Anim_Create(battle,"sa",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,battle.sa,90-battle.sa,10);
		break;
		
	case 90:
	Anim_Create(battle,"sa",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,battle.sa,180-battle.sa,10)
		break;
		
	case 180:
		 Anim_Create(battle,"sa",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,battle.sa,-90-battle.sa,10)
		break;
		
	case 270:
		Anim_Create(battle,"sa",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,battle.sa,0-battle.sa,10);
		break;
}

if(Battle_GetState()==BATTLE_STATE.IN_TURN && moveable){


	switch(dir){
		case 0:
			x += move;
			break;
			
		case 90:
			y -= move;
			break;
			
		case 180:
			x -= move;
			break;
			
		case 270:
			y += move;
			break;
	}

	moving = 0;
	var SPD=Player_GetSpdTotal()
	var SPD=(Input_IsHeld(INPUT.CANCEL) ? SPD/2 : SPD);
	if(Input_IsHeld(INPUT.LEFT)){
		switch(dir){
			case 0:
				if(move < 0){
					move += gravity_jump;
				}
				if(jump_state = 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 90:
			case 270:
				repeat(5*SPD){
					if!(position_meeting(x-sprite_width/2,y,block)){
						x -= Player_GetSpdTotal()/10;
					}
					else{
						x = xprevious;	
					}
				}
				break;
		}
	}
	if(Input_IsHeld(INPUT.RIGHT)){
		switch(dir){
			case 180:
				if(move < 0){
					move += gravity_jump;
				}
				if(jump_state = 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 90:
			case 270:
				repeat(5*SPD){
					if!(position_meeting(x+sprite_width/2,y,block)){
					  x += Player_GetSpdTotal()/10;
					}
					else{
						x = xprevious;	
					}
				}
				break;
		}
	}
	if(Input_IsHeld(INPUT.UP)){
		switch(dir){
			case 270:
				if(move < 0){
					move += gravity_jump;
				}
				if(jump_state = 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 0:
			case 180:
				repeat(5*SPD){
					if!(position_meeting(x,y-sprite_height/2,block)){
					  y -= Player_GetSpdTotal()/10;
					}
					else{
						y = yprevious;	
					}
				}
				break;
		}
	}
	if(Input_IsHeld(INPUT.DOWN)){
		switch(dir){
			case 90:
				if(move < 0){
					move += gravity_jump;
				}
				if(jump_state = 0){
					move = -jump_speed;
					jump_state = 1;
				}
				break;
			
			case 0:
			case 180:
				repeat(5*SPD){
					if!(position_meeting(x,y+sprite_height/2,block)){
					  y += Player_GetSpdTotal()/10;
					}
					else{
						y = yprevious;	
					}
				}
				break;
		}
	}
	//移动和开始跳跃
}
