if(Battle_GetState()=BATTLE_STATE.IN_TURN&&moveable){
var _x = event_data[? "posX"]
var _y = event_data[? "posY"] 
image_angle=point_direction(x,y,_x,_y)-90
obj=instance_create_depth(x,y,DEPTH_BATTLE.SOUL+1,battle_soul_yellow_bullet)
obj.image_angle=image_angle
}