duration -= 1;
if (duration <= 0) {
    audio_play_sound(snd_bone_out, 0, false);
    instance_destroy();
}

if (follow) {
    angle = battle_board.angle;
    xx1 = battle_board.x + lengthdir_x(x1 - battle_board.x, -angle) + lengthdir_x(y1 - battle_board.y, -angle + 90);
    yy1 = battle_board.y + lengthdir_x(x1 - battle_board.x, -angle - 90) + lengthdir_x(y1 - battle_board.y, -angle);
    xx2 = battle_board.x + lengthdir_x(x2 - battle_board.x, -angle) + lengthdir_x(y2 - battle_board.y, -angle + 90);
    yy2 = battle_board.y + lengthdir_x(x2 - battle_board.x, -angle - 90) + lengthdir_x(y2 - battle_board.y, -angle);
    xx3 = battle_board.x + lengthdir_x(x1 - battle_board.x, -angle) + lengthdir_x(y2 - battle_board.y, -angle + 90);
    yy3 = battle_board.y + lengthdir_x(x1 - battle_board.x, -angle - 90) + lengthdir_x(y2 - battle_board.y, -angle);
    xx4 = battle_board.x + lengthdir_x(x2 - battle_board.x, -angle) + lengthdir_x(y1 - battle_board.y, -angle + 90);
    yy4 = battle_board.y + lengthdir_x(x2 - battle_board.x, -angle - 90) + lengthdir_x(y1 - battle_board.y, -angle);
} else {
    xx1 = x1;
    yy1 = y1;
    xx2 = x2;
    yy2 = y2;
}