mainboard.x = x;
mainboard.y = y;
mainboard.angle = angle;
mainboard.left = left;
mainboard.right = right;
mainboard.up = up;
mainboard.down = down;
array_sort(global.boards_array,
function(a, b) {
    if (a.board_depth == b.board_depth) return a.board_number > b.board_number;
    return a.board_depth < b.board_depth;
})
