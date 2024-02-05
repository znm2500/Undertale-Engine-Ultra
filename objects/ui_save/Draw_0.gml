if(_state==0||_state==1){
	draw_sprite_ext(spr_pixel,0,108/2,118/2,424/2,174/2,0,c_white,1);
	draw_sprite_ext(spr_pixel,0,(108+6)/2,(118+6)/2,(424-6*2)/2,(174-6*2)/2,0,c_black,1);
}

if(_state==0){
		draw_sprite_ext(spr_battle_soul,0,(108+6+37+_choice_soul*180)/2,(118+6+131)/2,1/2,1/2,90,c_red,1);
}