///@arg pause,length,duration,*type,*follow,*spr_body,*spr_end
function Battle_MakeBoneWallTop(){
    var PAUSE = argument[0]
    var LENGTH = argument[1]
    var DURATION = argument[2]
    var COLOR = (0 << 0)
	var OBJ=0
	var SPR_BODY=spr_bone
	var SPR_END=spr_bone
    if (argument_count >= 4)
        COLOR = argument[3]
    if (argument_count >= 5)
        OBJ = argument[4]
    if (argument_count >= 6)
        SPR_BODY = argument[5]
    if (argument_count >= 7)
        SPR_END = argument[6]
	var SPR_HEIGHT=max(sprite_get_height(SPR_END),sprite_get_height(SPR_BODY))+1
    var ii = 0
    for (i = -3; i < ((battle_board.left + battle_board.right) + SPR_HEIGHT); i += SPR_HEIGHT)
    {
        ii += 1
		if(DURATION!=-1){
        b[ii] = Battle_MakeBoneV(((battle_board.x - battle_board.left) + i), (((battle_board.y - battle_board.up) - (LENGTH / 2)) - 5), LENGTH, 0, 0, COLOR, 0, 0, 0, ((DURATION + (PAUSE * 2)) + 24))
		}else{
		b[ii] = Battle_MakeBoneV(((battle_board.x - battle_board.left) + i), (((battle_board.y - battle_board.up) - (LENGTH / 2)) - 5), LENGTH, 0, 0, COLOR, 0, 0, 0, DURATION)
		}
		b[ii].follow=OBJ
        with (b[ii])
        {a = instance_create_depth(0, 0, 0, shaker)
			if(!follow){a.var_name = "x"
            Anim_Create(id, "y", 0, 0, y, LENGTH, 8, PAUSE)
			if(DURATION!=-1){
            Anim_Create(id, "y", 0, 0, (y + LENGTH), ((-LENGTH) * 2), 16, ((16 + PAUSE) + DURATION))}
			}  
			else{a.var_name = "xx"
				Anim_Create(id, "yy", 0, 0, yy, LENGTH, 8, PAUSE)
			if(DURATION!=-1){
            Anim_Create(id, "yy", 0, 0, (yy + LENGTH), ((-LENGTH) * 2), 16, ((16 + PAUSE) + DURATION))}
			}
			
            a.target = id
            
            a.shake_distance = 2
            a.shake_speed = 1
            a.shake_random = 0
            a.shake_decrease = 1
            a.delay = (PAUSE + 8)
        }
    }
    a = instance_create_depth(0, 0, 0, bone_box)
    a.duration = PAUSE
    a.x1 = ((battle_board.x - battle_board.left) + 1)
    a.y1 = (((battle_board.y - battle_board.up) + LENGTH) - 1)
    a.x2 = ((battle_board.x + battle_board.right) - 2)
    a.y2 = (battle_board.y - battle_board.up)
	a.follow=OBJ
    audio_stop_sound(snd_exclamation)
    audio_play_sound(snd_exclamation, 0, false)
    return;
}