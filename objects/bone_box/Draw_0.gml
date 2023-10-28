if (follow) {
    angle = battle_board.angle;
    
    xx1 = battle_board.x + lengthdir_x(x1 - center_x, -angle) + lengthdir_x(y1 - center_y, -angle + 90);
    yy1 = battle_board.y + lengthdir_x(x1 - center_x, -angle - 90) + lengthdir_x(y1 - center_y, -angle);
    
    xx2 = battle_board.x + lengthdir_x(x2 - center_x, -angle) + lengthdir_x(y2 - center_y, -angle + 90);
    yy2 = battle_board.y + lengthdir_x(x2 - center_x, -angle - 90) + lengthdir_x(y2 - center_y, -angle);
    
    xx3 = battle_board.x + lengthdir_x(x1 - center_x, -angle) + lengthdir_x(y2 - center_y, -angle + 90);
    yy3 = battle_board.y + lengthdir_x(x1 - center_x, -angle - 90) + lengthdir_x(y2 - center_y, -angle);
    
    xx4 = battle_board.x + lengthdir_x(x2 - center_x, -angle) + lengthdir_x(y1 - center_y, -angle + 90);
    yy4 = battle_board.y + lengthdir_x(x2 - center_x, -angle - 90) + lengthdir_x(y1 - center_y, -angle);
} else {
    xx1 = x1;
    xx2 = x2;
    xx3 = x2;
    xx4 = x1;
    
    yy1 = y1;
    yy2 = y2;
    yy3 = y1;
    yy4 = y2;
}

draw_set_color(color);
surface_set_target(Battle_GetBoardSurface());

draw_line(xx1, yy1, xx3, yy3);
draw_line(xx1, yy1, xx4, yy4);
draw_line(xx2, yy2, xx3, yy3);
draw_line(xx2, yy2, xx4, yy4);

surface_reset_target();