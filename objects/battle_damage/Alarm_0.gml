visible=true;
Anim_Create(id,"_bar_hp",0,0,bar_hp_original,bar_hp_target-bar_hp_original,bar_duration);

vsp=(-4/1.5);
gra=0.5/2*global.delta_time_factor;

alarm[1]=display_time / global.delta_time_factor + 1;