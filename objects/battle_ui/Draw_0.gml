var color;
if (Player_GetKR() > 0){
    color = make_color_rgb(255,0,255);
}
else{
	color = c_white;
}

draw_set_font(font_mars_needs_cunnilingus);
draw_text_ext_transformed_color(x,y,Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.NAME)+"   LV "+string(Player_GetLv()),-1,-1,1,1,0,c_white,c_white,c_white,c_white,1);
draw_sprite_ext(spr_battle_ui_hp,0,x+214,y+4,1,1,0,c_white,1);

draw_sprite_ext(spr_pixel,0,x+245,y-1,Player_GetHpMax()*1.25,20,0,make_color_rgb(192,0,0),1);
draw_sprite_ext(spr_pixel,0,x+245,y-1,Player_GetHp()*1.25,20,0,make_color_rgb(255,255,0),1);

draw_sprite_ext(spr_pixel,0,x + 245+Player_GetHp()*1.25,y-1,Player_GetKR()*1.25,20,0,color,1)

draw_text_ext_transformed_color(x+245+Player_GetHpMax()*1.25+14,y,"    "+string((Player_GetHp() + Player_GetKR()))+" / "+string(Player_GetHpMax()),-1,-1,1,1,0,color,color,color,color,1);
draw_sprite_ext(spr_battle_ui_kr,0,x+245+Player_GetHpMax()*1.25+10,y+4,1,1,0,color,1);