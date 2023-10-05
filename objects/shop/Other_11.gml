/// @description Create Typer
if(_typer_left_refresh)
{
	if(_state!=SHOP_STATE.SELL)
	{
		var dx;

		if(_state == SHOP_STATE.MENU)
		{
			dx = width_text;
		}
		else
		{
			dx = width_heart;
		}

		_typer_left = instance_create_depth(border_x1+dx,border_y1+height_text,0,text_typer);
	}
	else
	{
		if(_choice_state == 0)
			_typer_left = instance_create_depth(border_x1+width_heart,border_y1+height_text,0,text_typer);
		else
			_typer_left = instance_create_depth(95, border_y1 + 21,0,text_typer);
	}

}
if(_typer_right_refresh)
{
	if(_state!=SHOP_STATE.SELL){
		if!(_state = SHOP_STATE.BUY||_state = SHOP_STATE.DIALOG){
			_typer_right = instance_create_depth(menu_divide_x+width_text,border_y1+height_text,0,text_typer);
		}
		else{
			_typer_right = instance_create_depth(menu_divide_x+width_text-6,border_y1+height_text,0,text_typer);
		}
	}
	else
	{
		if(_choice_state == 0)
			_typer_right = instance_create_depth(border_x1+width_heart+160,border_y1+height_text,0,text_typer);
		else
			_typer_right = noone;
	}

}
if(_typer_state_refresh)
{
	if(_state!=SHOP_STATE.SELL){
		_typer_state_0 = instance_create_depth(menu_divide_x+width_text-4,state_info_y+height_text,0,text_typer);
		_typer_state_1 = instance_create_depth(menu_divide_x+width_text-4+50,state_info_y+height_text,0,text_typer);
	}
	else{
		_typer_state_0 = instance_create_depth(menu_divide_x,state_info_y+height_text,0,text_typer);
	}
}
if(_typer_info_refresh)
{
	if(_state==SHOP_STATE.BUY && _index<4 && _index>=0)
	{
		_typer_info = instance_create_depth(menu_divide_x+width_text-10,buy_info_inst_y+height_text,98,text_typer);

	}
	else
		_typer_info = noone;
}