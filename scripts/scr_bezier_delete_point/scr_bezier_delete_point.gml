/// @param bezier
/// @param index
function scr_bezier_delete_point(_bezier,_ind){
	if(_ind<0){
		return(-1);
	}
	return(array_delete(_bezier[$ "points"],_ind,1));
}