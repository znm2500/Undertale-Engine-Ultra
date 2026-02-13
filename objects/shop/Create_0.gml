var SHOP=Storage_GetTempFlag(FLAG_TEMP_SHOP);
depth = 97;

// 设定位置

border_x1 = 0;
border_y1 = 120;
border_x2 = 319;
border_y2 = 239;
border_width = 4;

width_text = 25;
width_heart = 30;
height_text = 10;

menu_divide_x = 209;
state_info_y = 200;

buy_info_x = menu_divide_x;
buy_info_y = border_y1 - 80;
buy_info_inst_y = border_y1;
buy_info__vspeedpeed = 8;

_index = 0;
_indexy = 0;
_index_buy = 0;
_index_sell = 0;
_choice_state = 0;
_pre_index = 0;
_pre_index_buy = 0;
_pre_index_sell = 0;
_exit_index = 0;

_host = instance_create_depth(160,border_y1,-100,Shop_GetHost(SHOP));


var i=0;
for(i=0;i<4;i++)
{
	_item[i]=_host.shop_item[i];
}
_background = Shop_GetBackground(SHOP);

_typer_left = noone;
_typer_right = noone;
_typer_info = noone;
_typer_state_0 = noone;
_typer_state_1 = noone;
_typer_left_refresh = true;
_typer_right_refresh = true;
_typer_info_refresh = true;
_typer_state_refresh = true;

_state = SHOP_STATE.ENCOUNTER;
_dialog = false;

_pre="{color `white`}{scale 1}{voice 0}{speed 2}{space_y 4}{shadow true}{depth "+string(DEPTH_UI.TEXT)+"}";
_pre_inst="{color `white`}{font 1}{scale 1}{space_y 4}{shadow true}{instant true}{depth "+string(DEPTH_UI.TEXT)+"}";
_pre_inst_2="{color `white`}{scale 1}{space_y 2}{shadow true}{instant true}{depth 98}";
_pre_inst_3="{color `white`}{scale 1}{space_y 1}{shadow true}{instant true}{depth "+string(DEPTH_UI.TEXT)+"}";
//
_snd_buy_item = snd_buyitem;

Shop_CallEvent(_state);