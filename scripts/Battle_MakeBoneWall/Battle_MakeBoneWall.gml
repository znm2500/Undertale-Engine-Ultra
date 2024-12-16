function Battle_MakeBoneWallBottom(pause, length, duration, type = 0, follow = 0) {

    var SPR_HEIGHT = max(sprite_get_height(spr_bone), sprite_get_height(spr_bone)) + 1;
    var ii = 0;

    for (i = -3; i < ((battle_board.left + battle_board.right) + SPR_HEIGHT); i += SPR_HEIGHT) {
        ii += 1;

        if (duration != -1) {
            b[ii] = Battle_MakeBone(((battle_board.x - battle_board.left) + i), (((battle_board.y + battle_board.down) + (length / 2)) + 5), length, 0, 0, type, 0,90, 0, 0, ((duration + (pause * 2)) + 24));
        } else {
            b[ii] = Battle_MakeBone(((battle_board.x - battle_board.left) + i), (((battle_board.y + battle_board.down) + (length / 2)) + 5), length, 0, 0, type, 0,90, 0, 0, duration);
        }

        b[ii].follow = follow;
        b[ii].follow_board = follow;
        with(b[ii]) {
            a = instance_create_depth(0, 0, 0, shaker);

            if (follow) {
                a.var_name = "_x";
                Anim_Create(id, "_y", 0, 0, _y, ( - length), 8, pause);

                if (duration != -1) {
                    Anim_Create(id, "_y", 0, 0, (_y - length), (length * 2), 16, ((16 + pause) + duration));
                }
            } else {
                a.var_name = "x";
                Anim_Create(id, "y", 0, 0, y, ( - length), 8, pause);

                if (duration != -1) {
                    Anim_Create(id, "y", 0, 0, (y - length), (length * 2), 16, ((16 + pause) + duration));
                }
            }

            a.target = id;
            a.shake_distance = 2;
            a.shake_speed = 1;
            a.shake_random = 0;
            a.shake_decrease = 1;
            a.delay = (pause + 8);
        }
    }

    a = instance_create_depth(0, 0, 0, bone_box);
    a.duration = pause;
    a.x1 = ((battle_board.x - battle_board.left));
    a.y1 = (((battle_board.y + battle_board.down) - length) + 1);
    a.x2 = ((battle_board.x + battle_board.right) - 1);
    a.y2 = ((battle_board.y + battle_board.down) - 1);
    a.follow = follow;
    audio_stop_sound(snd_exclamation);
    audio_play_sound(snd_exclamation, 0, false);
    return b;
}

function Battle_MakeBoneWallLeft(pause, length, duration, type = 0, follow = false) {

    var SPR_HEIGHT = max(sprite_get_height(spr_bone), sprite_get_height(spr_bone)) + 1;
    var ii = 0;

    for (i = 0; i < ((battle_board.up + battle_board.down) + SPR_HEIGHT); i += SPR_HEIGHT) {
        ii += 1;

        if (duration != -1) {
            b[ii] = Battle_MakeBone((((battle_board.x - battle_board.left) - (length / 2)) - 5), ((battle_board.y - battle_board.up) + i), length, 0, 0, type, 0,0, 0, 0, ((duration + (pause * 2)) + 24));
        } else {
            b[ii] = Battle_MakeBone((((battle_board.x - battle_board.left) - (length / 2)) - 5), ((battle_board.y - battle_board.up) + i), length, 0, 0, type, 0, 0, 0, duration);
        }

        b[ii].follow = follow;
        b[ii].follow_board = follow;
        with(b[ii]) {
            a = instance_create_depth(0, 0, 0, shaker);

            if (!follow) {
                a.var_name = "y";
                Anim_Create(id, "x", 0, 0, x, length, 8, pause);

                if (duration != -1) {
                    Anim_Create(id, "x", 0, 0, (x + length), (( - length) * 2), 16, ((16 + pause) + duration));
                }
            } else {
                a.var_name = "_y";
                Anim_Create(id, "_x", 0, 0, _x, length, 8, pause);

                if (duration != -1) {
                    Anim_Create(id, "_x", 0, 0, (_x + length), (( - length) * 2), 16, ((16 + pause) + duration));
                }
            }

            a.target = id;
            a.shake_distance = 2;
            a.shake_speed = 1;
            a.shake_random = 0;
            a.shake_decrease = 1;
            a.delay = (pause + 8);
        }
    }

    a = instance_create_depth(0, 0, 0, bone_box);
    a.duration = pause;
    a.follow = follow;
    a.x1 = ((battle_board.x - battle_board.left));
    a.y1 = ((battle_board.y - battle_board.up));
    a.x2 = (((battle_board.x - battle_board.left) + length));
    a.y2 = ((battle_board.y + battle_board.down) - 1);
    audio_stop_sound(snd_exclamation);
    audio_play_sound(snd_exclamation, 0, false);
    return b;
}

function Battle_MakeBoneWallRight(pause, length, duration, type = 0, follow = false) {

    var SPR_HEIGHT = max(sprite_get_height(spr_bone), sprite_get_height(spr_bone)) + 1;
    var ii = 0;

    for (i = 0; i < ((battle_board.up + battle_board.down) + SPR_HEIGHT); i += SPR_HEIGHT) {
        ii += 1;
        if (duration != -1) {
            b[ii] = Battle_MakeBone((((battle_board.x + battle_board.right) + (length / 2)) + 5), ((battle_board.y - battle_board.up) + i), length, 0, 0, type, 0,180, 0, 0, ((duration + (pause * 2)) + 24));
        } else {
            b[ii] = Battle_MakeBone((((battle_board.x + battle_board.right) + (length / 2)) + 5), ((battle_board.y - battle_board.up) + i), length, 0, 0, type, 0,180, 0, 0, duration);
        }

        b[ii].follow = follow;
        b[ii].follow_board = follow;
        with(b[ii]) {
            a = instance_create_depth(0, 0, 0, shaker);
            if (!follow) {
                a.var_name = "y";
                Anim_Create(id, "x", 0, 0, x, ( - length), 8, pause);
                if (duration != -1) {
                    Anim_Create(id, "x", 0, 0, (x - length), (length * 2), 16, ((16 + pause) + duration));
                }
            } else {
                a.var_name = "_y";
                Anim_Create(id, "_x", 0, 0, _x, ( - length), 8, pause);
                if (duration != -1) {
                    Anim_Create(id, "_x", 0, 0, (_x - length), (length * 2), 16, ((16 + pause) + duration));
                }
            }

            a.target = id;
            a.shake_distance = 2;
            a.shake_speed = 1;
            a.shake_random = 0;
            a.shake_decrease = 1;
            a.delay = (pause + 8);
        }
    }

    a = instance_create_depth(0, 0, 0, bone_box);
    a.duration = pause;
    a.x1 = ((battle_board.x + battle_board.right) - 1);
    a.y1 = ((battle_board.y - battle_board.up));
    a.x2 = ((battle_board.x + battle_board.right) - length - 1);
    a.y2 = ((battle_board.y + battle_board.down) - 1);
    a.follow = follow;
    audio_stop_sound(snd_exclamation);
    audio_play_sound(snd_exclamation, 0, false);
    return b;
}

function Battle_MakeBoneWallTop(pause, length, duration, type = 0, follow = false) {

    var SPR_HEIGHT = max(sprite_get_height(spr_bone), sprite_get_height(spr_bone)) + 1;
    var ii = 0;

    for (i = -3; i < ((battle_board.left + battle_board.right) + SPR_HEIGHT); i += SPR_HEIGHT) {
        ii += 1;
        if (duration != -1) {
            b[ii] = Battle_MakeBone(((battle_board.x - battle_board.left) + i), (((battle_board.y - battle_board.up) - (length / 2)) - 5), length, 0, 0, type, 0,-90, 0, 0, ((duration + (pause * 2)) + 24));
        } else {
            b[ii] = Battle_MakeBone(((battle_board.x - battle_board.left) + i), (((battle_board.y - battle_board.up) - (length / 2)) - 5), length, 0, 0, type, 0, -90,0, 0, duration);
        }
        b[ii].follow = follow;
        b[ii].follow_board = follow;
        with(b[ii]) {
            a = instance_create_depth(0, 0, 0, shaker);
            if (!follow) {
                a.var_name = "x";
                Anim_Create(id, "y", 0, 0, y, length, 8, pause);
                if (duration != -1) {
                    Anim_Create(id, "y", 0, 0, (y + length), (( - length) * 2), 16, ((16 + pause) + duration));
                }
            } else {
                a.var_name = "_x";
                Anim_Create(id, "_y", 0, 0, _y, length, 8, pause);
                if (duration != -1) {
                    Anim_Create(id, "_y", 0, 0, (_y + length), (( - length) * 2), 16, ((16 + pause) + duration));
                }
            }

            a.target = id;
            a.shake_distance = 2;
            a.shake_speed = 1;
            a.shake_random = 0;
            a.shake_decrease = 1;
            a.delay = (pause + 8);
        }
    }

    a = instance_create_depth(0, 0, 0, bone_box);
    a.duration = pause;
    a.x1 = ((battle_board.x - battle_board.left));
    a.y1 = (((battle_board.y - battle_board.up) + length));
    a.x2 = ((battle_board.x + battle_board.right) - 1);
    a.y2 = (battle_board.y - battle_board.up);
    a.follow = follow;
    audio_stop_sound(snd_exclamation);
    audio_play_sound(snd_exclamation, 0, false);
    return b;
}

function Battle_MakeBoneWallRound(rotatespeed, radius, type, pause, duration = -1) {

    var bone = Makebonecircle(round((battle_board.down + battle_board.right + battle_board.left + battle_board.up) / 22), 0, type, battle_board.x, battle_board.y, (battle_board.down + battle_board.right + battle_board.left + battle_board.up) / 2, (battle_board.down + battle_board.right + battle_board.left + battle_board.up) / 2, 0, 0, 1, rotatespeed);

    Anim_Create(bone, "length", 0, 0, 0, 2 * (bone.size_x - radius - 5), 16, pause);

    if (duration != -1) {
        Anim_Create(bone, "length", 0, 0, 2 * (bone.size_x - radius - 5), -2 * (bone.size_x - radius - 5), 16, (16 + pause + duration));
    }

    var boneBox = instance_create_depth(0, 0, 0, bone_box_round);
	boneBox.circle = true;
    boneBox.duration = pause;
    boneBox.gap = radius;

    audio_stop_sound(snd_exclamation);
    audio_play_sound(snd_exclamation, 0, false);

    return bone;
}