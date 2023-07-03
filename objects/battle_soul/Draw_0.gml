var STATE=Battle_GetState();
var MENU=Battle_GetMenu();
if(STATE==BATTLE_STATE.IN_TURN || STATE==BATTLE_STATE.TURN_PREPARATION || (STATE==BATTLE_STATE.MENU && MENU!=BATTLE_MENU.FIGHT_AIM && MENU!=BATTLE_MENU.FIGHT_ANIM && MENU!=BATTLE_MENU.FIGHT_DAMAGE)){
	draw_self();
}
if(STATE==BATTLE_STATE.IN_TURN){
	draw_sprite_ext(sprite_index,image_index,x,y,1.6,1.6,image_angle,c_white,al)
	draw_sprite_ext(spr_soul_light,image_index,x,y,s,s,image_angle,color,1)
	draw_sprite_ext(spr_soul_guangbiao,index,x,y,ss,ss,0,c_white,1)
	}







