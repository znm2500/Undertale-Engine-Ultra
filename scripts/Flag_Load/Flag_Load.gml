///@arg type
function Flag_Load() {
	var TYPE=argument[0];
	var PATH="";
	if(argument_count>=2){
		PATH=argument[1];
	}

	if(PATH==""){
		PATH=Flag_GetSavePath(TYPE);
	}

	if(!file_exists(PATH)){
	
		return false;
	}

	var file=file_text_open_read(PATH);

	var str=file_text_read_string(file);
	Flag_SetRaw(TYPE,str);

	file_text_close(file);



	return true;


}
