///@arg x,y,length,hspeed,vspeed,type,out,angle,rotate,auto_destroy,duration,follow,follow_board,follow_target,follow_angle,point,point_at,follow_x,follow_y
function Battle_MakeBone() {
    var OBJ = 0;
    var DURATION = -1;
    var X = argument[0];
    var Y = argument[1];
    var LENGTH = argument[2];
    var HSPEED = argument[3];
    var VSPEED = argument[4];
    var COLOR = argument[5];
    var OUT = argument[6];
    var ANGLE = argument[7];
    var ROT = argument[8];
    var DESTROY = argument[9];

    if (argument_count >= 11) DURATION = argument[10];

    if (argument_count >= 12) OBJ = argument[11];

    var bone = instance_create_depth(X, Y, 0, battle_bullet_bone);
    bone.length = LENGTH;
    bone.hspeed = HSPEED;
    bone.vspeed = VSPEED;
    bone.type = COLOR;
    bone.out = OUT;
    bone.rotate = ROT;
    bone.auto_destroy = DESTROY;
    bone.angle = ANGLE;
    bone._angle = ANGLE;
    bone.duration = DURATION;
    bone.follow = OBJ;
    if (argument_count >= 13) {
        bone.follow_board = argument[12];
        if (OBJ) {
			bone.follow_angle = battle_board.angle;
            var pos = RotateAround(battle_board.x, battle_board.y, X, Y, battle_board.x, battle_board.y, battle_board.angle);
            bone.x = pos[0];
            bone.y = pos[1];
        }
    }
    if (argument_count >= 14) {
        bone.follow_target = argument[13];
        if (OBJ && instance_exists(bone.follow_target)) {
            bone.follow_angle = bone.follow_target.angle;
            var pos = RotateAround(bone.follow_target.x, bone.follow_target.y, X, Y, bone.follow_target.x, bone.follow_target.y, bone.follow_target.angle);
            bone.x = pos[0];
            bone.y = pos[1];
        }
    }
    if (argument_count >= 15&&argument[14]!=noone) {
        bone.follow_angle = argument[14];
    }

    if (argument_count >= 16) bone.point = argument[15];

    if (argument_count >= 17) bone.point_at = argument[16];

    if (argument_count >= 19&&argument[17]!=noone&&argument[18]!=noone) {
        bone.follow_x = argument[17];
        bone.follow_y = argument[18];
        if (OBJ) {
            var pos = RotateAround(bone.follow_x, bone.follow_y, X, Y, bone.follow_x, bone.follow_y, bone.follow_angle);
            bone.x = pos[0];
            bone.y = pos[1];
        }
    }	
    return bone;
}
///@arg x,length,hspeed,type,out,rotate,auto_destroy,*duration,*follow,*follow_board,*follow_target,*follow_angle,*point,*point_at,*follow_x,*follow_y
function Battle_MakeBoneBottom() {
    var X = argument[0];
    var LENGTH = argument[1];
    var HSPEED = argument[2];
    var COLOR = argument[3];
    var OUT = argument[4];
    var ROT = argument[5];
    var DESTROY = argument[6];
    var DURATION = -1;
    var FOLLOW = false;
    var FOLLOW_BOARD = false;
    var FOLLOW_ANGLE = noone;
    var POINT = 0;
    var POINT_AT = 0;
    var FOLLOW_X = noone;
    var FOLLOW_Y = noone;
    var FOLLOW_TARGET = noone;

    if (argument_count >= 8) DURATION = argument[7];
    if (argument_count >= 9) FOLLOW = argument[8];
    if (argument_count >= 10) FOLLOW_BOARD = argument[9];
    if (argument_count >= 11) FOLLOW_TARGET = argument[10];
    if (argument_count >= 12) FOLLOW_ANGLE = argument[11];
    if (argument_count >= 13) POINT = argument[12];
    if (argument_count >= 14) POINT_AT = argument[13];
    if (argument_count >= 16) {
        FOLLOW_X = argument[14];
        FOLLOW_Y = argument[15];
    }
    var Y = (((battle_board.y + battle_board.down) - (LENGTH / 2)) - 5);
    if (argument[12] == 1) {
        Y = battle_board.y + battle_board.down;
    }
    var bone = Battle_MakeBone(X, Y, LENGTH, HSPEED, 0, COLOR, OUT, 90, ROT, DESTROY, DURATION, FOLLOW, FOLLOW_BOARD, FOLLOW_TARGET, FOLLOW_ANGLE, POINT, POINT_AT, FOLLOW_X, FOLLOW_Y);
    return bone;
}
///@arg y,length,vspeed,type,out,rotate,auto_destroy,*duration,*follow,*follow_board,*follow_target,*follow_angle,*point,*point_at,*follow_x,*follow_y
function Battle_MakeBoneLeft() {
    var Y = argument[0];
    var LENGTH = argument[1];
    var VSPEED = argument[2];
    var COLOR = argument[3];
    var OUT = argument[4];
    var ROT = argument[5];
    var DESTROY = argument[6];
    var DURATION = -1;
    var FOLLOW = false;
    var FOLLOW_BOARD = false;
    var FOLLOW_ANGLE = noone;
    var POINT = 0;
    var POINT_AT = 0;
    var FOLLOW_X = noone;
    var FOLLOW_Y = noone;
    var FOLLOW_TARGET = noone;
    if (argument_count >= 8) DURATION = argument[7];
    if (argument_count >= 9) FOLLOW = argument[8];
    if (argument_count >= 10) FOLLOW_BOARD = argument[9];
    if (argument_count >= 11) FOLLOW_TARGET = argument[10];
    if (argument_count >= 12) FOLLOW_ANGLE = argument[11];
    if (argument_count >= 13) POINT = argument[12];
    if (argument_count >= 14) POINT_AT = argument[13];
    if (argument_count >= 16) {
        FOLLOW_X = argument[14];
        FOLLOW_Y = argument[15];
    }
    var X = (((battle_board.x - battle_board.left) + (LENGTH / 2)) + 5);
    if (argument[12] == 1) {
        X = battle_board.x - battle_board.left;
    }
    var bone = Battle_MakeBone(X, Y, LENGTH, 0, VSPEED, COLOR, OUT, 0, ROT, DESTROY, DURATION, FOLLOW, FOLLOW_BOARD, FOLLOW_TARGET, FOLLOW_ANGLE, POINT, POINT_AT, FOLLOW_X, FOLLOW_Y);

    return bone;
}
///@arg y,length,vspeed,type,out,rotate,auto_destroy,*duration,*follow,*follow_board,*follow_target,*follow_angle,*point,*point_at,*follow_x,*follow_y
function Battle_MakeBoneRight() {
    var Y = argument[0];
    var LENGTH = argument[1];
    var VSPEED = argument[2];
    var COLOR = argument[3];
    var OUT = argument[4];
    var ROT = argument[5];
    var DESTROY = argument[6];
    var DURATION = -1;
    var FOLLOW = false;
    var FOLLOW_BOARD = false;
    var FOLLOW_ANGLE = noone;
    var POINT = 0;
    var POINT_AT = 0;
    var FOLLOW_X = noone;
    var FOLLOW_Y = noone;
    var FOLLOW_TARGET = noone;
    if (argument_count >= 8) DURATION = argument[7];
    if (argument_count >= 9) FOLLOW = argument[8];
    if (argument_count >= 10) FOLLOW_BOARD = argument[9];
    if (argument_count >= 11) FOLLOW_TARGET = argument[10];
    if (argument_count >= 12) FOLLOW_ANGLE = argument[11];
    if (argument_count >= 13) POINT = argument[12];
    if (argument_count >= 14) POINT_AT = argument[13];
    if (argument_count >= 16) {
        FOLLOW_X = argument[14];
        FOLLOW_Y = argument[15];
    }
    var X = (((battle_board.x + battle_board.right) - (LENGTH / 2)) - 5);
    if (argument[12] == 1) {
        X = battle_board.x + battle_board.right;
    }
    var bone = Battle_MakeBone(X, Y, LENGTH, 0, VSPEED, COLOR, OUT, 180, ROT, DESTROY, DURATION, FOLLOW, FOLLOW_BOARD, FOLLOW_TARGET, FOLLOW_ANGLE, POINT, POINT_AT, FOLLOW_X, FOLLOW_Y);

    return bone;
}
///@arg x,length,hspeed,type,out,rotate,auto_destroy,*duration,*follow,*follow_board,*follow_target,*follow_angle,*point,*point_at,*follow_x,*follow_y
function Battle_MakeBoneTop() {
    var X = argument[0];
    var LENGTH = argument[1];
    var HSPEED = argument[2];
    var COLOR = argument[3];
    var OUT = argument[4];
    var ROT = argument[5];
    var DESTROY = argument[6];
    var DURATION = -1;
    var FOLLOW = false;
    var FOLLOW_BOARD = false;
    var FOLLOW_ANGLE = noone;
    var POINT = 0;
    var POINT_AT = 0;
    var FOLLOW_X = noone;
    var FOLLOW_Y = noone;
    var FOLLOW_TARGET = noone;
    if (argument_count >= 8) DURATION = argument[7];
    if (argument_count >= 9) FOLLOW = argument[8];
    if (argument_count >= 10) FOLLOW_BOARD = argument[9];
    if (argument_count >= 11) FOLLOW_TARGET = argument[10];
    if (argument_count >= 12) FOLLOW_ANGLE = argument[11];
    if (argument_count >= 13) POINT = argument[12];
    if (argument_count >= 14) POINT_AT = argument[13];
    if (argument_count >= 16) {
        FOLLOW_X = argument[14];
        FOLLOW_Y = argument[15];
    }
    var Y = (((battle_board.y - battle_board.up) + (LENGTH / 2)) + 5);
    if (argument[12] == 1) {
        Y = battle_board.y - battle_board.up;
    }
    var bone = Battle_MakeBone(X, Y, LENGTH, HSPEED, 0, COLOR, OUT, 270, ROT, DESTROY, DURATION, FOLLOW, FOLLOW_BOARD,FOLLOW_TARGET, FOLLOW_ANGLE, POINT, POINT_AT, FOLLOW_X, FOLLOW_Y);

    return bone;
}
///@arg x,y,vspeed,type,out,rotate,gap,auto_destroy,*duration,*follow,*follow_board,*follow_target,*follow_angle,*point,*point_at,*follow_x,*follow_y
function Battle_MakeBoneTwoH() {
    var X = argument[0];
    var Y = argument[1];
    var VSPEED = argument[2];
    var TYPE = argument[3];
    var OUT = argument[4];
    var ROTATE = argument[5];
    var GAP = argument[6];
    var DESTROY = argument[7];
    var DURATION = -1;
    var FOLLOW = false;
    var FOLLOW_BOARD = false;
    var FOLLOW_ANGLE = noone;
    var POINT = 0;
    var POINT_AT = 0;
    var FOLLOW_X = noone;
    var FOLLOW_Y = noone;
    var FOLLOW_TARGET = noone;
    var bones = [];

    if (argument_count >= 9) DURATION = argument[8];
    if (argument_count >= 10) FOLLOW = argument[9];
    if (argument_count >= 11) FOLLOW_BOARD = argument[10];
    if (argument_count >= 12) FOLLOW_TARGET = argument[11];
    if (argument_count >= 13) FOLLOW_ANGLE = argument[12];
    if (argument_count >= 14) POINT = argument[13];
    if (argument_count >= 15) POINT_AT = argument[14];
    if (argument_count >= 17) {
        FOLLOW_X = argument[15];
        FOLLOW_Y = argument[16];
    }

    var boneLeft = Battle_MakeBoneLeft(Y, (((X - battle_board.x) + battle_board.left) - GAP), VSPEED, TYPE, OUT, ROTATE, DESTROY, DURATION, FOLLOW, FOLLOW_BOARD, FOLLOW_TARGET, FOLLOW_ANGLE, POINT, POINT_AT, FOLLOW_X, FOLLOW_Y);
    var boneRight = Battle_MakeBoneRight(Y, (((battle_board.x + battle_board.right) - GAP) - X), VSPEED, TYPE, OUT, ROTATE, DESTROY, DURATION, FOLLOW, FOLLOW_BOARD, FOLLOW_TARGET, FOLLOW_ANGLE, POINT, POINT_AT, FOLLOW_X, FOLLOW_Y);

    bones[0] = boneLeft;
    bones[1] = boneRight;
    return bones;
}
///@arg x,y,hspeed,type,out,rotate,gap,auto_destroy,*duration,*follow,*follow_board,*follow_target,*follow_angle,*point,*point_at,*follow_x,*follow_y
function Battle_MakeBoneTwoV() {
    var X = argument[0];
    var Y = argument[1];
    var HSPEED = argument[2];
    var TYPE = argument[3];
    var OUT = argument[4];
    var ROTATE = argument[5];
    var GAP = argument[6];
    var DESTROY = argument[7];
    var DURATION = -1;
    var FOLLOW = false;
    var FOLLOW_BOARD = false;
    var FOLLOW_ANGLE = noone;
    var POINT = 0;
    var POINT_AT = 0;
    var FOLLOW_X = noone;
    var FOLLOW_Y = noone;
    var FOLLOW_TARGET = noone;
    var bones = [];

    if (argument_count >= 9) DURATION = argument[8];
    if (argument_count >= 10) FOLLOW = argument[9];
    if (argument_count >= 11) FOLLOW_BOARD = argument[10];
    if (argument_count >= 12) FOLLOW_TARGET = argument[11];
    if (argument_count >= 13) FOLLOW_ANGLE = argument[12];
    if (argument_count >= 14) POINT = argument[13];
    if (argument_count >= 15) POINT_AT = argument[14];
    if (argument_count >= 17) {
        FOLLOW_X = argument[15];
        FOLLOW_Y = argument[16];
    }

    var boneLeft = Battle_MakeBoneTop(X, (((Y - battle_board.y) + battle_board.up) - GAP), HSPEED, TYPE, OUT, ROTATE, DESTROY, DURATION, FOLLOW, FOLLOW_BOARD, FOLLOW_TARGET, FOLLOW_ANGLE, POINT, POINT_AT, FOLLOW_X, FOLLOW_Y);
    var boneRight = Battle_MakeBoneBottom(X, (((battle_board.y + battle_board.down) - GAP) - Y), HSPEED, TYPE, OUT, ROTATE, DESTROY, DURATION, FOLLOW, FOLLOW_BOARD, FOLLOW_TARGET, FOLLOW_ANGLE, POINT, POINT_AT, FOLLOW_X, FOLLOW_Y);

    bones[0] = boneLeft;
    bones[1] = boneRight;
    return bones;
}
///@arg number,angle,type,x,y,size_x,size_y,length,out,*roting,*rot,*extra_angle,*rotate,*duration,*rott
function Makebonecircle() {
    var Number = argument[0]
    var Size = argument[1]
    var Type = argument[2]
    var Out = argument[8]
    var Enable = argument[9]
    var Rot = argument[10]
    var Ex = argument[11]
    var X = argument[3]
    var Y = argument[4]
    var H = argument[5]
    var V = argument[6]
    var L = argument[7]
    var II = argument[12]

    var bone = instance_create_depth(X, Y, 0, bone_circle);
    bone.number = Number;
    bone.type = Type;
    bone.angle = Size;
    bone.out = Out;
    bone.roting = Enable == undefined ? 1 : Enable;
    bone.extra_angle = Ex == undefined ? 0 : Ex;
    bone.rot = Rot == undefined ? 0 : Rot;
    bone.size_x = H;
    bone.size_y = V;
    bone.length = L;
    bone.rotate = II == undefined ? 0 : II;
    bone.duration = argument[13] == undefined ? -1 : duration;
    bone.rott = argument[14] == undefined ? 0 : duration;
    return bone;
}
/// @arg x,y,angle_x,angle_y,angle_z,rotate_x,rotate_y,rotate_z,scale_x,scale_y,scale_z,vspeed,hspeed,shape,type,out,*duration,*gap
function Battle_MakeBone3D() {
    var _x = argument[0];
    var _y = argument[1];
    var angle_x = argument[2];
    var angle_y = argument[3];
    var angle_z = argument[4];
    var rotate_x = argument[5];
    var rotate_y = argument[6];
    var rotate_z = argument[7];
    var scale_x = argument[8];
    var scale_y = argument[9];
    var scale_z = argument[10];
    var VSPEED = argument[11];
    var _hspeed = argument[12];
    var shape = argument[13];
    var type = argument[14];
    var out = argument[15];
    var duration = argument_count > 16 ? argument[16] : -1;
    var GAP = argument_count > 17 ? argument[17] : 40;
    var inst = instance_create_depth(_x, _y, 0, battle_bullet_bone_3d);
    inst.anglex = angle_x;
    inst.angley = angle_y;
    inst.anglez = angle_z;
    inst.angxs = rotate_x;
    inst.angys = rotate_y;
    inst.angzs = rotate_z;
    inst.scalex = scale_x;
    inst.scaley = scale_y;
    inst.scalez = scale_z;
    inst.vspeed = VSPEED;
    inst.hspeed = HSPEED;
    inst.shape = shape;
    inst.type = type;
    inst.out = out;
    inst.duration = duration;
    inst.gap = GAP;
    return inst;
}
///@arg x,y,length,hspeed,vspeed,type,out,angle,rotate,auto_destroy,*duration,*scale,*extra_angle,*follow,*follow_board,*follow_angle,*point,*point_at,*follow_x,*follow_y
function Battle_MakeBoneArrow() {
    var OBJ = 0;
    var DURATION = -1;
    var SCALE = 0.5;
    var EXTRA_ANGLE = 30;
    var X = argument[0];
    var Y = argument[1];
    var LENGTH = argument[2];
    var HSPEED = argument[3];
    var VSPEED = argument[4];
    var COLOR = argument[5];
    var OUT = argument[6];
    var ANGLE = argument[7];
    var ROT = argument[8];
    var DESTROY = argument[9];
    if (argument_count >= 11) var DURATION = argument[10];
    if (argument_count >= 12) var SCALE = argument[11];
    if (argument_count >= 13) var EXTRA_ANGLE = argument[12];
    if (argument_count >= 14) OBJ = argument[13];

    var bone = instance_create_depth(X, Y, 0, bone_arrow);
    bone.length = LENGTH;
    bone.hspeed = HSPEED;
    bone.vspeed = VSPEED;
    bone.type = COLOR;
    bone.out = OUT;
    bone.rotate = ROT;
    bone.auto_destroy = DESTROY;
    bone.angle = ANGLE;
    bone._angle = ANGLE;
    bone.duration = DURATION;
    bone.scale = SCALE;
    bone.extra_angle = EXTRA_ANGLE;
    bone.follow = OBJ;

    if (argument_count >= 15) bone.follow_board = argument[14];
    if (argument_count >= 16) bone.follow_angle = argument[15];
    if (argument_count >= 17) bone.point = argument[16];
    if (argument_count >= 18) bone.point_at = argument[17];
    if (argument_count >= 20) {
        bone.follow_x = argument[18];
        bone.follow_y = argument[19];
    }

    return bone;
}