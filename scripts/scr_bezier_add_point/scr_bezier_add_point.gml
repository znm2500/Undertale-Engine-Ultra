/// @param bezier
/// @param x
/// @param y
function scr_bezier_add_point(_bezier,_x,_y){
	return(array_push(_bezier[$ "points"],[_x,_y]));
}