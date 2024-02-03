/// @description Refresh Typer
Shop_ClearTyper();
Shop_CreateTyper();

switch(_state)
{
	case SHOP_STATE.MENU:
		if(_typer_left_refresh)
			_typer_left.text = _pre + _host.menu_text;
		if(_typer_right_refresh)
			_typer_right.text = _pre_inst + "  Buy&  Sell&  Talk&  Exit";	
		
		//_typer_state.text = _pre_inst + string(Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.GOLD))+"G   "+string(Item_GetNumber())+"/8";
		if(_typer_state_refresh)
		{
			var GOLD = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.GOLD);
			shop._typer_state_0.text = shop._pre_inst + string(GOLD)+"G";
			shop._typer_state_1.text = shop._pre_inst+string(Item_GetNumber())+"/8";
		}
		break;
	case SHOP_STATE.BUY:
		if(instance_exists(_typer_info)&&_typer_info_refresh)
		{
			_typer_info.text = _pre_inst_2 + _host.shop_item[_index]._shop_description;
		}
		if(_typer_left_refresh)
		{
			_typer_left.text = _pre_inst;
			var i = 0;
			var MAXLENGTH = 0;
			for(i=0;i<4;i++)
			{
				var ITEM = _item[i];
				var LEN = string_length(string(ITEM._price_buy));
				if(LEN>MAXLENGTH)
					MAXLENGTH=LEN;
			}
			for(i=0;i<4;i++)
			{
				var ITEM = _item[i];
				var LEN = string_length(string(ITEM._price_buy));
				if(MAXLENGTH - LEN > 0)
				{
					repeat(MAXLENGTH - LEN)
					{
						_typer_left.text+=" ";
					}
				}
				_typer_left.text+=string(ITEM._price_buy)+"G - "+ITEM._name+"&";
			}
			_typer_left.text+="Exit";
		}
		
		if(_typer_right_refresh)
		{
			switch(_choice_state)
			{
				case 0:
				default:
					_typer_right.text = _pre + _host.buy_before_text;
					break;
				case 1:
					_typer_right.text = _pre_inst_3 + "Buy it for&" + string(_item[_index]._price_buy)+"G?& Yes& No";
					break;
				case 2:
					_typer_right.text = _pre + _host.buy_after_text;
					break;
				case 3:
					_typer_right.text = _pre + _host.buy_false_text_0;
					break;
				case 4:
					_typer_right.text = _pre + _host.buy_false_text_1;
					break;
			}
		}
		
		//_typer_state.text = _pre_inst + string(Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.GOLD))+"G   "+string(Item_GetNumber())+"/8";
		if(_typer_state_refresh)
		{
			var GOLD = Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.GOLD);
			shop._typer_state_0.text = shop._pre_inst + string(GOLD)+"G";
			shop._typer_state_1.text = shop._pre_inst+string(Item_GetNumber())+"/8";
		}
		break;
	case SHOP_STATE.SELL:
		if(_host.sold_available){
			if(_choice_state == 0)
			{
				var MAXLENGTH = 0;
				var NUM = Item_GetNumber();
				var i,LEN,GOLD,ITEM;
				for(i=0;i<NUM;i++)
				{
					LEN = string_length(string(Item_GetSellGold(Item_Get(i))));
					if(LEN>MAXLENGTH)
						MAXLENGTH=LEN;
				}
				if(_typer_left_refresh)
				{
					_typer_left.text = _pre_inst;
					for(i=0;i<4;i++)
					{
						if(2*i<NUM)
						{
							ITEM = Item_Get(2*i);
							GOLD = Item_GetSellGold(ITEM);
							LEN = string_length(string(GOLD));
							if(MAXLENGTH - LEN > 0)
							{
								repeat(MAXLENGTH - LEN)
									_typer_left.text += " ";
							}
							_typer_left.text += string(GOLD)+"G - "+Item_GetName(ITEM);
						}
						_typer_left.text+="&";
					}
					_typer_left.text+="Exit";
				}
				if(_typer_right_refresh)
				{
					_typer_right.text = _pre_inst;
					for(i=0;i<4;i++)
					{
						if((2*i+1)<NUM)
						{
							ITEM = Item_Get(2*i+1);
							GOLD = Item_GetSellGold(ITEM);
							LEN = string_length(string(GOLD));
							if(MAXLENGTH - LEN > 0)
							{
								repeat(MAXLENGTH - LEN)
									_typer_right.text += " ";
							}
							_typer_right.text += string(GOLD)+"G - "+Item_GetName(ITEM);
						}
						_typer_right.text+="&";
					}
				}
			}
			else
			{
				if(_typer_left_refresh)
				{
					_typer_left.text = _pre_inst;
					_typer_left.text += "Sell it for "+string(Item_GetSellGold(Item_Get(_index)))+"G?&&";
					_typer_left.text += "  Yes      No";
				}
			}
			if(_typer_state_refresh)
			{
				_typer_state_0.text = _pre_inst+"{color `yellow`}("+string(Player_GetGold())+"G)";
			}
		}
		break;
	case SHOP_STATE.DIALOG:
		if(_typer_left_refresh)
		{
			_typer_left.text = _pre_inst;
			var i = 0;
			
			for(i=0;i<4;i++)
			{
			_typer_left.text += Shop_GetDialogTitle(i) + "&";
			}
			_typer_left.text += "{color `white`}Exit";
		}
		if(_typer_right_refresh)
			_typer_right.text = _pre + _host.dialog_before_text;
		break;
	default:
		break;
}