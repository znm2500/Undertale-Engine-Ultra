surface_set_target(Battle_GetBoardSurface());
{
    draw_self();
}
surface_reset_target();

switch(type)
{
    case 0:
        image_blend = c_white;
        break;
    case 1:
        image_blend = make_color_rgb(20,196,255);
        break;
    case 2:
        image_blend = make_color_rgb(248,148,29);
        break;
    case 3:
        image_blend = make_color_rgb(0, 255, 0);
        break;
    case 4:
        image_blend = c_yellow;
        break;
}