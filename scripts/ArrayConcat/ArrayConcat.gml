function ArrayConcat(_arr1,_arr2){
	var result = _arr1;
	var len = array_length(_arr1)+array_length(_arr2);
	var count = 0;
	for(var i=array_length(_arr1);i<len;i++){
		result[i]=_arr2[count];
		count++;
	}
	return(result);
}
