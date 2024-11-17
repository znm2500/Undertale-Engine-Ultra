    draw_set_color(make_color_rgb(64, 0, 64));
    surface_set_target(Battle_GetBoardSurface());
    for (var i = 0; i < array_length(point); i++) {
        if (point[i].horizontal) {
            draw_line_width(point[i].x - 1000, point[i].y - 1, point[i].x + 1000, point[i].y - 1, 2);
        }
        if (point[i].vertical) {
            draw_line_width(point[i].x - 1, point[i].y - 1000, point[i].x - 1, point[i].y + 1000, 2);
        }
    }
    surface_reset_target();