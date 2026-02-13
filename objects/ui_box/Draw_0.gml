if (!surface_exists(_surface)) {
    _surface = surface_create(640, 480);
}
if (!surface_exists(_surface_text)) {
    _surface_text = surface_create(640, 480);
}
if (_state == 0) {
    surface_set_target(_surface);
    draw_sprite_ext(spr_pixel, 0, (320 - _show_width), 16, (_show_width) * 2, 450, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, (320 - (_show_width >= 6 ? _show_width - 6 : 0)), 22, (_show_width >= 6 ? _show_width - 6 : 0) * 2, 450 - 6 * 2, 0, c_black, 1);
    draw_sprite_ext(spr_pixel, 0, (8 + 3 + 149.5) * 2, (8 + 3 + 36) * 2, 1, 300, 0, c_white, 1);
    draw_sprite_ext(spr_pixel, 0, (8 + 3 + 150.5) * 2, (8 + 3 + 36) * 2, 1, 300, 0, c_white, 1);

   var items=Item_GetInventoryItems();
		var proc=0;
		var count=items.GetCount();
		repeat(8){
			if(proc>=count){
				draw_sprite_ext(spr_pixel,0,16+6+58,16+6+71+32*proc,180,1,0,c_red,1);
			}
			proc+=1;
		}
		var box=Item_GetInventoryBoxes(box_slot);
		var proc=0;
		var count=box.GetCount();
		repeat(10){
			if(proc>=count){
				draw_sprite_ext(spr_pixel,0,16+6+58+302,16+6+71+32*proc,180,1,0,c_red,1);
			}
			proc+=1;
		}

    draw_sprite_ext(spr_battle_soul, 0, (8 + 3 + 13.5 + 151 * _choice_mode_soul) * 2, (8 + 3 + 34.5 + 16 * _choice_item_soul) * 2, 1, 1, 90 * !global.classic_ui, c_red, 1);
    surface_reset_target()
}
surface_set_target(global.surface_gui);
draw_surface_part_ext(_surface, 320 - (_show_width >= 6 ? _show_width: 0), 0, (_show_width >= 6 ? _show_width: 0) * 2, 480, 320 - (_show_width >= 6 ? _show_width: 0), 0, 1, 1, c_white, 1);
draw_surface_part_ext(_surface_text, 320 - (_show_width >= 6 ? _show_width: 0), 0, (_show_width >= 6 ? _show_width: 0) * 2, 480, 320 - (_show_width >= 6 ? _show_width: 0), 0, 1, 1, c_white, 1);
surface_reset_target();
surface_set_target(_surface);
draw_clear_alpha(c_white, 0);
surface_reset_target();
surface_set_target(_surface_text);
draw_clear_alpha(c_white, 0);
surface_reset_target();