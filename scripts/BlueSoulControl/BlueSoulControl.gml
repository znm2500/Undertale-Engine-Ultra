///@arg dir,*impact_speed
function BlueSoulControl(){
	
		Battle_SetSoul(battle_soul_blue)
	
	battle_soul.impact=true
	battle_soul.dir=argument[0]
	if(argument_count>1){
	battle_soul.move=argument[1]}else{
	battle_soul.move=10}
	battle_soul.jump_state = 2;
	battle_soul.on_block = 0;
	battle_soul.on_board = 0;
	battle_soul.on_platform = 0;
}