vsp+=gra
y+=vsp*global.delta_time_factor
if(y>ystart){
	gravity=0;
	vspeed=0;
	y=ystart;
}