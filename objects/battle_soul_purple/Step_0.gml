event_inherited();

var SPD = Player_GetSpdTotal();
SPD = (Input_IsHeld(INPUT.CANCEL) ? SPD/2 : SPD);
if(moveable){
repeat (SPD * 10)
{
    if (v_moving)
    {
        if (Input_IsHeld(INPUT.UP))
        {
            if (!position_meeting(x, y - sprite_height/2, block))
            {
                y -= 0.1;
                x = x_on;
            }
        }
        
        if (Input_IsHeld(INPUT.DOWN))
        {
            if (!position_meeting(x, y + sprite_height/2, block))
            {
                y += 0.1;
                x = x_on;
            }
        }
    }
    
    if (h_moving)
    {
        if (Input_IsHeld(INPUT.LEFT))
        {
            if (!position_meeting(x - sprite_width/2, y, block))
            {
                x -= 0.1;
                y = y_on;
            }
        }
        
        if (Input_IsHeld(INPUT.RIGHT))
        {
            if (!position_meeting(x + sprite_width/2, y, block))
            {
                x += 0.1;
                y = y_on;
            }
        }
    }
}
if(!moving){
if(!h_moving&&x_index>0&&battle_board.x-battle_board.left<px[x_index-1]&&Input_IsPressed(INPUT.LEFT)){
	Anim_Create(id,"x",0,0,x,px[x_index-1]-x,5)
	 Anim_Create(id, "moving", 0, 0, 1, -1, 5);}
if(!h_moving&&x_index<array_length(px)-1&&battle_board.x+battle_board.up>px[x_index+1]&&Input_IsPressed(INPUT.RIGHT)){Anim_Create(id,"x",0,0,x,px[x_index+1]-x,5)
	 Anim_Create(id, "moving", 0, 0, 1, -1, 5);}
if(!v_moving&&y_index>0&&battle_board.y-battle_board.up<py[y_index-1]&&Input_IsPressed(INPUT.UP)){
	Anim_Create(id,"y",0,0,y,py[y_index-1]-y,5)
	 Anim_Create(id, "moving", 0, 0, 1, -1, 5);}
if(!v_moving&&y_index<array_length(py)-1&&battle_board.y+battle_board.down>py[y_index+1]&&Input_IsPressed(INPUT.DOWN)){Anim_Create(id,"y",0,0,y,py[y_index+1]-y,5)
	 Anim_Create(id, "moving", 0, 0, 1, -1, 5);}
}}