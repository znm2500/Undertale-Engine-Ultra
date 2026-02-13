function Dialog_Start(choose_enable=0,choice1="",choice2="") {
	if(!instance_exists(ui_dialog)&&!Player_IsInBattle()){
		var d=instance_create_depth(0,0,0,ui_dialog);
		d._choose_enable=choose_enable
		if(choose_enable)d._choice=[choice1,choice2]
		return true;
	}else{
		return false;
	}


}