if(instance_exists(ui_dialog)){
	if(_menu!=-1){
		_menu=-1;
		event_user(0);
	}
}

if(_menu==-1){
	if(!instance_exists(ui_dialog)){
		instance_destroy();
	}
}else if(_menu==0){
	if(Input_IsPressed(INPUT.UP)){
		if(_choice>0){
			_choice-=1;
			Anim_Create(id,"_choice_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_soul,_choice-_choice_soul,15)
			audio_play_sound(snd_menu_switch,0,false);
		}
	}else if(Input_IsPressed(INPUT.DOWN)){
		if(_choice<(Phone_GetNumber()>0 ? 2 : 1)){
			_choice+=1;
			Anim_Create(id,"_choice_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_soul,_choice-_choice_soul,15)
			audio_play_sound(snd_menu_switch,0,false);
		}
	}else if(Input_IsPressed(INPUT.CONFIRM)){
		switch(_choice){
			case 0:
				if(Item_GetNumber()>0){
					_menu=1;
					event_user(0);
					audio_play_sound(snd_menu_confirm,0,false);
				}
				break;
			case 1:
				_menu=3;
				event_user(0);
				audio_play_sound(snd_menu_confirm,0,false);
				break;
			case 2:
				_menu=4;
				event_user(0);
				audio_play_sound(snd_menu_confirm,0,false);
				break;
		}
	}else if(Input_IsPressed(INPUT.MENU)||Input_IsPressed(INPUT.CANCEL)){
		instance_destroy();
	}
}else if(_menu==1){
	if(Input_IsPressed(INPUT.UP)){
		if(_choice_item>0){
			_choice_item-=1;
			Anim_Create(id,"_choice_item_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_item_soul,_choice_item-_choice_item_soul,15)
			audio_play_sound(snd_menu_switch,0,false);
		}
	}else if(Input_IsPressed(INPUT.DOWN)){
		if(_choice_item<Item_GetNumber()-1){
			_choice_item+=1;
			Anim_Create(id,"_choice_item_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_item_soul,_choice_item-_choice_item_soul,15)
			audio_play_sound(snd_menu_switch,0,false);
		}
	}else if(Input_IsPressed(INPUT.CONFIRM)){
		_menu=2;
		event_user(0);
		audio_play_sound(snd_menu_confirm,0,false);
	}else if(Input_IsPressed(INPUT.CANCEL)){
		_menu=0;
		event_user(0);
	}
}else if(_menu==2){
	if(Input_IsPressed(INPUT.LEFT)){
		if(_choice_item_operate>0){
			_choice_item_operate-=1;
			audio_play_sound(snd_menu_switch,0,false);
			 switch (_choice_item_operate) {
        case 0:
		Anim_Create(id,"_choice_item_operate_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_item_operate_soul,11.5-_choice_item_operate_soul,15)
            break;
        case 1:
            Anim_Create(id,"_choice_item_operate_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_item_operate_soul,59.5-_choice_item_operate_soul,15)
            break;
        case 2:
            Anim_Create(id,"_choice_item_operate_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_item_operate_soul,116.5-_choice_item_operate_soul,15)
            break;
    }
		}
	}else if(Input_IsPressed(INPUT.RIGHT)){
		if(_choice_item_operate<2){
			_choice_item_operate+=1;
			audio_play_sound(snd_menu_switch,0,false);
			switch (_choice_item_operate) {
        case 0:
		Anim_Create(id,"_choice_item_operate_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_item_operate_soul,11.5-_choice_item_operate_soul,15)
            break;
        case 1:
            Anim_Create(id,"_choice_item_operate_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_item_operate_soul,59.5-_choice_item_operate_soul,15)
            break;
        case 2:
            Anim_Create(id,"_choice_item_operate_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_item_operate_soul,116.5-_choice_item_operate_soul,15)
            break;
    }
		}
	}else if(Input_IsPressed(INPUT.CONFIRM)){
		//TODO
		_menu=-1;
		event_user(0);
		switch(_choice_item_operate){
			case 0:
				Item_CallEvent(Item_Get(_choice_item),ITEM_EVENT.USE,_choice_item);
				break;
			case 1:
				Item_CallEvent(Item_Get(_choice_item),ITEM_EVENT.INFO,_choice_item);
				break;
			case 2:
				Item_CallEvent(Item_Get(_choice_item),ITEM_EVENT.DROP,_choice_item);
				break;
		}
		audio_play_sound(snd_menu_confirm,0,false);
	}else if(Input_IsPressed(INPUT.CANCEL)){
		_menu=1;
		event_user(0);
	}
}else if(_menu==3){
	if(Input_IsPressed(INPUT.CANCEL)){
		_menu=0;
		event_user(0);
	}
}else if(_menu==4){
	if(Input_IsPressed(INPUT.UP)){
		if(_choice_phone>0){
			_choice_phone-=1;
			Anim_Create(id,"_choice_phone_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_phone_soul,_choice-_choice_phone_soul,15)
			audio_play_sound(snd_menu_switch,0,false);
		}
	}else if(Input_IsPressed(INPUT.DOWN)){
		if(_choice_phone<Phone_GetNumber()-1){
			_choice_phone+=1;
			Anim_Create(id,"_choice_phone_soul",ANIM_TWEEN.CUBIC,ANIM_EASE.OUT,_choice_phone_soul,_choice-_choice_phone_soul,15)
			audio_play_sound(snd_menu_switch,0,false);
		}
	}else if(Input_IsPressed(INPUT.CONFIRM)){
		Phone_CallEvent(Phone_Get(_choice_phone),PHONE_EVENT.CALL,_choice_phone);
		_menu=-1;
		event_user(0);
		audio_play_sound(snd_menu_confirm,0,false);
	}else if(Input_IsPressed(INPUT.CANCEL)){
		_menu=0;
		event_user(0);
	}
}