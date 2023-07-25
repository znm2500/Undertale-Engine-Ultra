///@desc Soul Collision
Battle_CallSoulEventHurt();
switch(type)
{
    case 0:
        Player_Hurt(1);
        break;
    case 1:
         if(Input_IsHeld(INPUT.UP)||Input_IsHeld(INPUT.DOWN)||Input_IsHeld(INPUT.LEFT)||Input_IsHeld(INPUT.RIGHT)||Input_IsPressed(INPUT.UP)||Input_IsPressed(INPUT.DOWN)||Input_IsPressed(INPUT.LEFT)||Input_IsPressed(INPUT.RIGHT)){
		
		Player_Hurt(1)}
        break;
    case 2:
        if(!(Input_IsHeld(INPUT.UP)||Input_IsHeld(INPUT.DOWN)||Input_IsHeld(INPUT.LEFT)||Input_IsHeld(INPUT.RIGHT)||Input_IsPressed(INPUT.UP)||Input_IsPressed(INPUT.DOWN)||Input_IsPressed(INPUT.LEFT)||Input_IsPressed(INPUT.RIGHT))){
		
		Player_Hurt(1)}
        break;
    case 3:
        Player_Heal(1)
        break;
    case 4:
         Player_Hurt(1);
        break;
}
if(disposable){instance_destroy()}