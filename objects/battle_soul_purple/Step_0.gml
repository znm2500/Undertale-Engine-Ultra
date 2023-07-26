event_inherited();

px = [];
py = [];

// 按照水平和垂直位置，收集坐标
for (var i = 0; i < array_length(point); i++) { 
	if (point[i].horizontal) {
		array_push(py, point[i].y);
	}
	if (point[i].vertical) {
		array_push(px, point[i].x);
	}
}

array_sort(px, true);
array_sort(py, true);

h_moving = 0;
v_moving = 0;

// 获取最近的水平点和垂直点
for (var i = 0; i < array_length(px); i++) {
	if (x >= px[i] - 5 && x <= px[i] + 5 ) {
		v_moving = 1;
		x_on = px[i];
		x_index = i;
	}
}

for (var i = 0; i < array_length(py); i++) {
	if (y >= py[i] - 5 && y <= py[i] + 5 ) {
		y_on = py[i];
		h_moving = 1;
		y_index = i;
	}
}

var SPD = Player_GetSpdTotal();
SPD = (Input_IsHeld(INPUT.CANCEL) ? SPD / 2 : SPD);

// 根据输入移动角色
if (moveable) {
	repeat (SPD * 10) {
		if (v_moving) {
			if (Input_IsHeld(INPUT.UP)) {
				if (!position_meeting(x, y - sprite_height/2, block)) {
					y -= 0.1;
					x = x_on;
					y_on = y;
				}
			}
        
			if (Input_IsHeld(INPUT.DOWN)) {
				if (!position_meeting(x, y + sprite_height/2, block)) {
					y += 0.1;
					x = x_on;
					y_on = y;
				}
			}
		}
    
		if (h_moving) {
			if (Input_IsHeld(INPUT.LEFT)) {
				if (!position_meeting(x - sprite_width/2, y, block)) {
					x -= 0.1;
					y = y_on;
					
					x_on = x;
				}
			}
        
			if (Input_IsHeld(INPUT.RIGHT)) {
				if (!position_meeting(x + sprite_width/2, y, block)) {
					x += 0.1;
					y = y_on;
					x_on = x;
				}
			}
			
		}
if (!moving) {
			if (!h_moving && x_index > 0 && battle_board.x - battle_board.left < px[x_index-1] && Input_IsPressed(INPUT.LEFT)) {
				x=px[x_index-1]
				
				x_on=px[x_index-1]
				Anim_Create(id,"moving",0,0,1,-1,5)
				;
			}
			
			else if (!h_moving && x_index < array_length(px) - 1 && battle_board.x + battle_board.up > px[x_index+1] && Input_IsPressed(INPUT.RIGHT)) {
				
				Anim_Create(id,"moving",0,0,1,-1,5)
				x=px[x_index+1]
				x_on=px[x_index+1]
			}
			
			else if (!v_moving && y_index > 0 && battle_board.y - battle_board.up < py[y_index-1] && Input_IsPressed(INPUT.UP)) {
				
				Anim_Create(id,"moving",0,0,1,-1,5)
				y=py[y_index-1]
				y_on=py[y_index-1]
			}
			
			else if (!v_moving && y_index < array_length(py) - 1 && battle_board.y + battle_board.down > py[y_index+1] && Input_IsPressed(INPUT.DOWN)) {
				
				Anim_Create(id,"moving",0,0,1,-1,5)
				y=py[y_index+1]
				y_on=py[y_index+1]
			}
			
		}
		
	
	}
}

// 如果没有按下或持续按下指定的输入，设置位置为最近点的位置

     if(!h_moving)x = x_on;
   else if(!v_moving)y = y_on;
