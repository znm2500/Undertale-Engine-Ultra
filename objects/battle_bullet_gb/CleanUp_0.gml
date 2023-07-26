if(instance_exists(_inst)){
	instance_destroy(_inst);
}
if(!instance_exists(battle_bullet_gb)){
	gamepad_set_vibration(0,0,0);
}