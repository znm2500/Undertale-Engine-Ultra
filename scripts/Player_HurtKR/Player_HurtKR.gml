function Player_HurtKR() {

battle.damage=1
return


}
function Player_GetKR() {
	return Flag_Get(FLAG_TYPE.STATIC,FLAG_STATIC.KR);


}
function Player_SetKR() {
	var KR=argument[0];

	var result=Flag_Set(FLAG_TYPE.STATIC,FLAG_STATIC.KR,KR);

	return result;


}

