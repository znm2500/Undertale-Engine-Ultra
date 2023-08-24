/// @param bezier
/// @param x
/// @param y
function Bezier_Add_Point(_bezier,_x,_y){
	return(array_push(_bezier[$ "points"],[_x,_y]));
}