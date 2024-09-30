if (!surface_exists(_surface)) {
    _surface = surface_create(640,480);
}
if (!surface_exists(_surface_text)) {
    _surface_text = surface_create(640,480);
}
surface_set_target(_surface);
if (_state == 0 || _state == 1) {
    draw_sprite_ext(spr_pixel, 0,  (320 - _show_width) ,  118 , _show_width*2, 174 , 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, (320 - (_show_width >= 6 ? _show_width - 6 : 0)) ,  (118 + 6) , 2*(_show_width >= 6 ? _show_width - 6 : 0), (174 - 6 * 2) , 0, c_black, 1);
}

if (_state == 0) { 
    draw_sprite_ext(spr_battle_soul, 0, (108 + 6 + 37 + _choice_soul * 180), (118 + 6 + 131), 1, 1, 90 * !global.classic_ui, c_red, 1);    
}
surface_reset_target();
surface_set_target(global.surface_gui);
draw_surface_part_ext(_surface, 320 - (_show_width >= 6 ? _show_width  : 0), 0, (_show_width >= 6 ? _show_width  : 0)*2 , 480, 320 - (_show_width >= 6 ? _show_width  : 0) , 0, 1,1, c_white, 1);
draw_surface_part_ext(_surface_text, 320 - (_show_width >= 6 ? _show_width - 6 : 0), 0, (_show_width >= 6 ? _show_width - 6 : 0)*2 , 480, 320 - (_show_width >= 6 ? _show_width - 6 : 0) , 0, 1,1, c_white, 1);
surface_reset_target();
surface_set_target(_surface);
draw_clear_alpha(c_white, 0);
surface_reset_target();
surface_set_target(_surface_text);
draw_clear_alpha(c_white, 0);
surface_reset_target();