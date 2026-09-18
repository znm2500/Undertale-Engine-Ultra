//code from cheetos engine
event_inherited();
depth = DEPTH_BATTLE.BULLET_OUTSIDE_HIGH;


image_xscale = 800;
image_yscale = 0;

blaster = {
	direction: DIR.DOWN, speed: 0,
	sprite_index: spr_gb, image_index: 0, 
	x: 0, y: 0, image_angle: 0, 
	image_xscale: 1, image_yscale: 1,
	image_blend: c_white, image_alpha: 1,
};
_blaster_yscale = 0;
target_x = 0;
target_y = 0;
target_angle = 0;

state = 0;
timer_move = 0;
timer_blast = 0;
timer_exit = 0;

time_move = 30;
time_delay = 16;
time_blast = 10;
time_stay = 0;

charge_sound = true;
blast_sound = true;
destroy = false;

