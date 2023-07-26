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
        image_blend = c_aqua;
        break;
    case 2:
        image_blend = c_orange;
        break;
    case 3:
        image_blend = make_color_rgb(0, 255, 0);
        break;
    case 4:
        image_blend = c_yellow;
        break;
}