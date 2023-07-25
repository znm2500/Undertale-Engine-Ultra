draw_set_color(make_color_rgb(128, 0, 128));

surface_set_target(Battle_GetBoardSurface());

for(var i = 0; i < array_length(point); i++) {
    if (point[i].horizontal) {
        draw_line(point[i].xx - 1000, point[i].yy, point[i].xx + 1000, point[i].yy);
    }
    if (point[i].vertical) {
        draw_line(point[i].xx, point[i].yy - 1000, point[i].xx, point[i].yy + 1000);
    }
} 

surface_reset_target();