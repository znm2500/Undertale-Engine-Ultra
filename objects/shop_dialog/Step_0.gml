if(shop._dialog && !instance_exists(shop_dialog_typer))
{
	if(instance_exists(next_dialog))
	{
		var i;
		for(i=0;i<4;i++)
		{
			if(shop._host.dialog[i] == id)
			{
				shop._host.dialog[i] = next_dialog;
				break;
			}
		}
	instance_destroy();	
	}
	
	
}