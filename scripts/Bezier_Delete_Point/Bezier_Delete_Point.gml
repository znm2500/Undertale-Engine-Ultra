/// @param bezier
/// @param index
function Bezier_Delete_Point(_bezier,_ind){
	if(_ind<0){
		return(-1);
	}
	return(array_delete(_bezier[$ "points"],_ind,1));
}