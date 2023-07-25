///@arg x
///@arg y
///@arg x_target
///@arg y_target
///@arg angle_start
///@arg angle_target
///@arg scale_x
///@arg scale_y
///@arg color
///@arg *pause 
///@arg *duration 
///@arg *time_move
function MakeGB() {
	var xx = argument[0];
	var yy = argument[1];
	var idealx = argument[2];
	var idealy = argument[3];
	var angle = argument[4];
	var idealrot = argument[5];
	var xscale = argument[6];
	var yscale = argument[7];
	var color = argument[8];
	
	var pause = 0;
	var duration = 0;
	var time_move = 0;

	if(argument_count >= 10){
		pause = argument[9];
	}

	if(argument_count >= 11){
		duration = argument[10];
	}

	if(argument_count >= 12){
		time_move = argument[11];
	}

	var bb = instance_create_depth(xx,yy,DEPTH_BATTLE.BULLET_OUTSIDE_HIGH,battle_bullet_gb);
	bb.x_target = idealx;
	bb.y_target = idealy;
	bb.angle_start = angle;
	bb.angle_target = idealrot;
	bb.scale_x = xscale;
	bb.scale_y = yscale;
	bb.type = color;
	bb.time_release_delay = pause;
	bb.time_beam_end_delay = duration;
	bb.time_move = time_move;

	return bb;
}