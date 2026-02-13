event_inherited();

//移动
if(Battle_GetState()==BATTLE_STATE.IN_TURN && moveable){
	var SPD=Player_GetSpdTotal()
	var SPD=(Input_IsHeld(INPUT.CANCEL) ? SPD/2 : SPD);
	repeat(SPD*10){
		if(Input_IsHeld(INPUT.UP)){
			if(!position_meeting(x,y-sprite_height/2,block)){
				y-=0.1;
			}
		}
		if(Input_IsHeld(INPUT.DOWN)){
			if(!position_meeting(x,y+sprite_height/2,block)){
				y+=0.1;
			}
		}
		if(Input_IsHeld(INPUT.LEFT)){
			if(!position_meeting(x-sprite_width/2,y,block)){
				x-=0.1;
			}
		}
		if(Input_IsHeld(INPUT.RIGHT)){
			if(!position_meeting(x+sprite_width/2,y,block)){
				x+=0.1;
			}
		}
	}
}


if(type)image_angle=point_direction(x,y,battle_soul_yellow_target.x,battle_soul_yellow_target.y)+90
else{image_angle=180}
if(Input_IsPressed(INPUT.CONFIRM)&&Battle_GetState()=BATTLE_STATE.IN_TURN&&type==0&&moveable){
obj=instance_create_depth(x,y,DEPTH_BATTLE.SOUL+1,battle_soul_yellow_bullet)
obj.image_angle=image_angle+180
//Anim_Create(obj,"x",0,0,obj.x,lengthdir_x(1000,image_angle+90)-obj.x,20)
//Anim_Create(obj,"y",0,0,obj.y,lengthdir_y(1000,image_angle+90)-obj.y,20)
}