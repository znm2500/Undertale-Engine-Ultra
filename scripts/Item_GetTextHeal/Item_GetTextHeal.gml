///@arg heal_hp
///@arg new_line*
function Item_GetTextHeal() {
	var HEAL=argument[0];
	var LINE=true;
	if(argument_count>=2){
		LINE=argument[1];
	}

	var result="";
	result+=(LINE ? "&" : "");
	result+="{define `HP` "+string(HEAL)+"}";

	if(Player_GetHp()>=Player_GetHpMax()){
		result+="* Your HP was maxed out.";
	}else{
		result+="* You recovered {insert HP} HP!";
	}

	return result;


}
