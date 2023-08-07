switch(_type)
{
    case 0:
        Player_HurtKR();
        break;
    case 1:
	if(battle_soul.image_blend==c_blue){
        if(Input_IsHeld(INPUT.UP)||Input_IsHeld(INPUT.DOWN)||Input_IsHeld(INPUT.LEFT)||Input_IsHeld(INPUT.RIGHT)||Input_IsPressed(INPUT.UP)||Input_IsPressed(INPUT.DOWN)||Input_IsPressed(INPUT.LEFT)||Input_IsPressed(INPUT.RIGHT)){
		
		Player_HurtKR()}}
		else{ if!(battle_soul.x = battle_soul.xprevious&&battle_soul.y = battle_soul.yprevious){
		
		Player_HurtKR()}}
        break;
    case 2:
        if(battle_soul.x = battle_soul.xprevious&&battle_soul.y = battle_soul.yprevious){
		
		Player_HurtKR()}
        break;
    case 3:
        Player_Heal(1)
        break;
    case 4:
         Player_Hurt(1);
        break;
}
