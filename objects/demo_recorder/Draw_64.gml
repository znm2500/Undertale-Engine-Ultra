if(_icon_show_tick<=45){
	draw_sprite_ext(spr_demo_recording,0,320,80,2,2,0,c_white,1);
}
draw_set_font(Lang_GetFont("dotumche"));
draw_set_halign(fa_center);
draw_set_color(c_red);
draw_text(320,100,string(_frame_number));
draw_set_halign(fa_left);