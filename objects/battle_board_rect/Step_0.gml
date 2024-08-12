angle += rotate;
if (instance_exists(rect)) {
    ds_list_clear(rect.listVertex);
    ds_list_add(rect.listVertex, [ - left, -up], [right, -up], [right, down], [ - left, down]);
    rect.angle = angle;
    rect.x = x;
    rect.y = y;
    rect.rect = 1;
	rect.cover = cover;
	rect.board_depth = board_depth;
    rect.updateDivide();
}