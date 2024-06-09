ds_list_clear(mainboard.listVertex);
ds_list_add(mainboard.listVertex, [ - left, -up], [right, -up], [right, down], [ - left, down]);
mainboard.x = x;
mainboard.y = y;
mainboard.angle = angle;
mainboard.color_frame = color_frame;
array_sort(global.boards_array,
function(a, b) {
    if (a.board_depth == b.board_depth) return a.id > b.id;
    return a.board_depth < b.board_depth;
})