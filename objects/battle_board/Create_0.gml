depth = DEPTH_BATTLE.BOARD;

_surface = -1;
_surface_border_extra = -1;
_surface_border_cover = -1;
_surface_final = -1;

x = BATTLE_BOARD.X;
y = BATTLE_BOARD.Y;

up = BATTLE_BOARD.UP;
down = BATTLE_BOARD.DOWN;
left = BATTLE_BOARD.LEFT;
right = BATTLE_BOARD.RIGHT;

angle = 0;
color_bg = c_black;
alpha_bg = 1;
color_frame = c_white;

edge = !global.classic_ui;
alpha_frame = 1;
_angle = 0;
global.boards_array = array_create(0);

event_user(5);