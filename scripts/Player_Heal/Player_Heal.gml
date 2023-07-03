///@arg heal
function Player_Heal() {
	var HEAL=argument[0];

	if(HEAL>=0){
		if(Player_GetHp()+HEAL>=Player_GetHpMax()){
			Player_SetKR(0);
			Player_SetHp(Player_GetHpMax());
		}
		else{
			if(Player_GetHp()+HEAL>=Player_GetHp()+Player_GetKR()){
				Player_SetHp(Player_GetHp()+HEAL);
				Player_SetKR(0);
			}
			else{
				Player_SetHp(Player_GetHp()+HEAL);
				Player_SetKR(Player_GetKR()-HEAL);
			}
		}
		return true;
	}else{
		if(Player_GetHp()+Player_GetKR()>=Player_GetHpMax()){
			Player_SetKR(0);
			Player_SetHp(Player_GetHpMax());
		}
		return Player_Hurt(-HEAL);
	}


}
