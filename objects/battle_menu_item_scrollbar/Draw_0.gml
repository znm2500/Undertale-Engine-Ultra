draw_sprite_ext(spr_battle_menu_item_scrollbar_dot,1,x,yd,1,1,0,c_white,alpha)

if(NUMBER>3){
	if(battle._menu_choice_item_first!=0){
		draw_sprite_ext(spr_battle_menu_item_scrollbar_arrow,0,x,yy1,1,1,0,c_white,alpha);
	}
	if(battle._menu_choice_item_first!=Item_GetNumber()-3){
		draw_sprite_ext(spr_battle_menu_item_scrollbar_arrow,0,x,yy2,1,-1,0,c_white,alpha)
	}
}
for(var i=0;i<NUMBER;i++){
draw_sprite_ext(spr_battle_menu_item_scrollbar_dot,0,x,yy[i],1,1,0,c_white,1)
}