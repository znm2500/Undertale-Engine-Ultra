draw_sprite(_background,0,0,0);
draw_sprite(_host,0,160,118);
var _state = shop._state;
if(_state==SHOP_STATE.BUY)
{
	draw_set_color(c_white);
	draw_rectangle(buy_info_x,buy_info_inst_y,border_x2,buy_info_inst_y+80,false);
	draw_set_color(c_black);
	draw_rectangle(buy_info_x+border_width+1,buy_info_inst_y+border_width,border_x2-border_width,buy_info_inst_y+80-border_width,false);
}