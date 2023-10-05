/// @description Clear Typer
if(instance_exists(_typer_left)&&_typer_left_refresh)
instance_destroy(_typer_left);
if(instance_exists(_typer_right)&&_typer_right_refresh)
instance_destroy(_typer_right);
if(instance_exists(_typer_state_0)&&_typer_state_refresh)
instance_destroy(_typer_state_0);
if(instance_exists(_typer_state_1)&&_typer_state_refresh)
instance_destroy(_typer_state_1);
if(instance_exists(_typer_info)&&_typer_info_refresh)
instance_destroy(_typer_info);