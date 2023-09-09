
draw_set_color(color);
surface_set_target(Battle_GetBoardSurface())
draw_line(x+lengthdir_x(diss,battle_board.angle+point_direction(xx,yy,x1,y1)),y+lengthdir_y(diss,battle_board.angle+point_direction(xx,yy,x1,y1)),x+lengthdir_x(diss,battle_board.angle+point_direction(xx,yy,x1,y2)),y+lengthdir_y(diss,battle_board.angle+point_direction(xx,yy,x1,y2)))
	draw_line(x+lengthdir_x(diss,battle_board.angle+point_direction(xx,yy,x1,y1)),y+lengthdir_y(diss,battle_board.angle+point_direction(xx,yy,x1,y1)),x+lengthdir_x(diss,battle_board.angle+point_direction(xx,yy,x2,y1)),y+lengthdir_y(diss,battle_board.angle+point_direction(xx,yy,x2,y1)))
		draw_line(x+lengthdir_x(diss,battle_board.angle+point_direction(xx,yy,x2,y2)),y+lengthdir_y(diss,battle_board.angle+point_direction(xx,yy,x2,y2)),x+lengthdir_x(diss,battle_board.angle+point_direction(xx,yy,x2,y1)),y+lengthdir_y(diss,battle_board.angle+point_direction(xx,yy,x2,y1)))
	draw_line(x+lengthdir_x(diss,battle_board.angle+point_direction(xx,yy,x2,y2)),y+lengthdir_y(diss,battle_board.angle+point_direction(xx,yy,x2,y2)),x+lengthdir_x(diss,battle_board.angle+point_direction(xx,yy,x1,y2)),y+lengthdir_y(diss,battle_board.angle+point_direction(xx,yy,x1,y2)))
surface_reset_target();
