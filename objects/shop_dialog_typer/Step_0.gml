if(fast&&Input_IsPressed(INPUT.CONFIRM)){
	instance_destroy();
}else if(instance_exists(_inst)){
	_inst.x=x+text_offset_x;
	_inst.y=y+text_offset_y;
	_inst._surface_target=global.surface_gui;
}else{
	instance_destroy();
}