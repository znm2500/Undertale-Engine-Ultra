depth = DEPTH_BATTLE.BOARD;

_surface = -1;
_surface_board_extra = -1;
_surface_board_cover = -1;
_surface_mask = -1;

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
func_boardsort = function(a, b) {
    if (a.board_depth == b.board_depth) return a.board_number > b.board_number;
    return a.board_depth < b.board_depth;
};
event_user(5);