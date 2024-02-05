function Input_Init() {
	//GMU_Input v1.1.0

	global._gmu_input=ds_map_create();
	global._gmu_input_state_override=ds_map_create();

	enum INPUT_TYPE{
		KEYBOARD,
		GAMEPAD,
		MOUSE
	};

	enum INPUT_STATE{
		NULL,
		HELD,
		PRESSED,
		RELEASED
	};

	return true;


}
function Input_Uninit() {
	var map=global._gmu_input;
	repeat(ds_map_size(map)){
		var key=ds_map_find_first(map);
		Input_Unbind(key);
	}
	ds_map_destroy(map);
	ds_map_destroy(global._gmu_input_state_override);
	return true;


}
///@arg input
function Input_Unbind() {
	var INPUT=argument[0];

	var map=global._gmu_input;
	if(ds_map_exists(map,INPUT)){
		var list=ds_map_find_value(map,INPUT);
		var proc=0;
		repeat(ds_list_size(list)){
			var map_bind=ds_list_find_value(list,proc);
			ds_map_destroy(map_bind);
			proc+=1;
		}
		ds_list_destroy(list);
		ds_map_delete(map,INPUT);
	
		return true;
	}else{
		return false;
	}


}
///@arg input
///@arg state
function Input_SetStateOverride() {
	var INPUT=argument[0];
	var STATE=argument[1];

	global._gmu_input_state_override[?INPUT]=STATE;

	return true;


}
///@arg input
function Input_RemoveStateOverride() {
	var INPUT=argument[0];

	var map=global._gmu_input_state_override;
	if(ds_map_exists(map,INPUT)){
		ds_map_delete(map,INPUT);
		return true;
	}else{
		return false;
	}


}
///@arg input
function Input_IsReleased() {
	var INPUT=argument[0];

	var state=Input_GetState(INPUT);
	return (state==INPUT_STATE.RELEASED);


}
///@arg input
function Input_IsPressed() {
	var INPUT=argument[0];

	var state=Input_GetState(INPUT);
	return (state==INPUT_STATE.PRESSED);


}
///@arg input
function Input_IsHeld() {
	var INPUT=argument[0];

	var state=Input_GetState(INPUT);
	return (state==INPUT_STATE.HELD||state==INPUT_STATE.PRESSED);


}
///@arg input
function Input_GetState() {
	var INPUT=argument[0];

	var map=global._gmu_input;
	var override=global._gmu_input_state_override;
	if(ds_map_exists(override,INPUT)){
		return override[?INPUT];
	}
	if(ds_map_exists(map,INPUT)){
		var list=ds_map_find_value(map,INPUT);
		var result=INPUT_STATE.NULL;
		var proc=0;
		repeat(ds_list_size(list)){
			var map_bind=ds_list_find_value(list,proc);
			var type=ds_map_find_value(map_bind,"type");
			var device=ds_map_find_value(map_bind,"device");
			var button=ds_map_find_value(map_bind,"button");
			switch(type){
				case INPUT_TYPE.KEYBOARD:
					if(keyboard_check(button)){
						result=INPUT_STATE.HELD;
					}
					if(keyboard_check_pressed(button)){
						result=INPUT_STATE.PRESSED;
					}
					if(keyboard_check_released(button)){
						result=INPUT_STATE.RELEASED;
					}
					break;
				case INPUT_TYPE.GAMEPAD:
					if(gamepad_button_check(device,button)){
						result=INPUT_STATE.HELD;
					}
					if(gamepad_button_check_pressed(device,button)){
						result=INPUT_STATE.PRESSED;
					}
					if(gamepad_button_check_released(device,button)){
						result=INPUT_STATE.RELEASED;
					}
					break;
				case INPUT_TYPE.MOUSE:
					if(mouse_check_button(button)){
						result=INPUT_STATE.HELD;
					}
					if(mouse_check_button_pressed(button)){
						result=INPUT_STATE.PRESSED;
					}
					if(mouse_check_button_released(button)){
						result=INPUT_STATE.RELEASED;
					}
					break;
			}
			proc+=1;
		}
		return result;
	}else{
		return INPUT_STATE.NULL;
	}


}
///@arg input
///@arg type
///@arg device
///@arg button
function Input_Bind() {

	var INPUT=argument[0];
	var TYPE=argument[1];
	var DEVICE=argument[2];
	var BUTTON=argument[3];

	if(TYPE>=INPUT_TYPE.KEYBOARD&&TYPE<=INPUT_TYPE.MOUSE){
		var map=global._gmu_input;
		var list=-1;
		var map_bind=-1;
		if(!ds_map_exists(map,INPUT)){
			list=ds_list_create();
			ds_map_add(map,INPUT,list);
		}else{
			list=ds_map_find_value(map,INPUT);
		}
		map_bind=ds_map_create();
		ds_map_add(map_bind,"type",TYPE);
		ds_map_add(map_bind,"device",DEVICE);
		ds_map_add(map_bind,"button",BUTTON);
	
		ds_list_add(list,map_bind);
	
		return true;
	}else{
		return false;
	}


}
