if (_top) {
    draw_sprite_ext(spr_pixel, 0, camera.x + 32 / 2, camera.y + 10 / 2, 578 / 2, 152 / 2, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, camera.x + 38 / 2, camera.y + 16 / 2, 566 / 2, 140 / 2, 0, c_black, 1);
} else {
    draw_sprite_ext(spr_pixel, 0, camera.x + 32 / 2, camera.y + 320 / 2, 578 / 2, 152 / 2, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, camera.x + 38 / 2, camera.y + 326 / 2, 566 / 2, 140 / 2, 0, c_black, 1);
}
if (instance_exists(_inst) && _inst._paused && _choose_enable) {
    draw_sprite_ext(spr_battle_soul, 0, camera.x + x + 11.5 * (string_width(" ") * _inst._scale_x) + _choose_soul * (string_width("         " + _choice[0]) * _inst._scale_x), camera.y + _inst.y + 2.5 * ((string_height(" ") + 1) * _inst._scale_y), 1 / 2, 1 / 2, 90*!global.classic_ui, c_red, 1)
}