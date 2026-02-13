if(_menu==0){
	if(_mode==1){
		draw_sprite(spr_bg_area_1,0,0,-120);
	}
}
if(_menu==0){
	draw_set_halign(fa_center);
	draw_set_valign(fa_bottom);
	draw_set_font(font_crypt_of_tomorrow);
	draw_set_color(c_gray);
	draw_text_transformed(320/2,476/2,"UNDERTALE (C) TOBY FOX 2015-"+string(date_get_year(date_current_datetime()))+"\nUNDERTALE ENGINE ULTRA"+ENGINE_VERSION+" BY TML&ZNM",1,1,0);
	draw_set_halign(fa_left);
	draw_set_valign(fa_top);
}

if(_menu==1){
	draw_set_color(c_white);
	draw_set_font(font_determination_mono);
	draw_text_transformed(280/2,110/2,_naming_name,1,1,0);
}

if(_menu==2||_menu==3){
	draw_set_color(c_white);
	draw_set_font(font_determination_mono);
	draw_text_transformed((_confirm_name_x+_confirm_name_offset_x)/2,(_confirm_name_y+_confirm_name_offset_y)/2,_naming_name,_confirm_name_scale/2,_confirm_name_scale/2,_confirm_name_angle);
}