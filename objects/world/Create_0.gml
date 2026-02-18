_time = 0;
_frame_skip = 0;
_frame_skipped = 0;
global.blur_strength = [0,0];//第一个元素是横向模糊强度，第二个是纵向模糊强度
global.blur_amount = 0;//也与模糊程度相关
global.classic_ui = 0;
global.Panel = battle_menu_fight_knife;
global.kr = 1;
global.surface_gui = surface_create(640, 480);
game_set_speed(120,gamespeed_fps)