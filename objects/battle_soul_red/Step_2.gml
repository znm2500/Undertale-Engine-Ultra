event_inherited();

if(Battle_GetState()==BATTLE_STATE.IN_TURN && moveable){
	if(xprevious = x&&yprevious = y){
		global.moving = 0;
	}
	else{
		global.moving = 1;
	}
}
else{
	global.moving = 0;
}