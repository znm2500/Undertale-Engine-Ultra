
draw_set_color(color);
surface_set_target(Battle_GetBoardSurface());

draw_line(xx1, yy1, xx3, yy3);
draw_line(xx1, yy1, xx4, yy4);
draw_line(xx2, yy2, xx3, yy3);
draw_line(xx2, yy2, xx4, yy4);

surface_reset_target();
