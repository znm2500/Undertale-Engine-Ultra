///@arg pause,length,duration,*type,*follow
function Battle_MakeBoneWallBottom() {
    var PAUSE = argument[0];
    var LENGTH = argument[1];
    var DURATION = argument[2];
    var COLOR = (0 << 0);
    var FOLLOW = false;
   
    if(argument_count >= 4)
        COLOR = argument[3];
    if(argument_count >= 5)
        FOLLOW = argument[4];
   
    var SPR_HEIGHT = max(sprite_get_height(spr_bone), sprite_get_height(spr_bone)) + 1;
    var ii = 0;
    
    for (i = -3; i < ((battle_board.left + battle_board.right) + SPR_HEIGHT); i += SPR_HEIGHT) {
        ii += 1;
        
        if(DURATION != -1) {
            b[ii] = Battle_MakeBoneV(((battle_board.x - battle_board.left) + i), (((battle_board.y + battle_board.down) + (LENGTH / 2)) + 5), LENGTH, 0, 0, COLOR, 0, 0, 0, ((DURATION + (PAUSE * 2)) + 24));
        }
        else {
            b[ii] = Battle_MakeBoneV(((battle_board.x - battle_board.left) + i), (((battle_board.y + battle_board.down) + (LENGTH / 2)) + 5), LENGTH, 0, 0, COLOR, 0, 0, 0, DURATION);
        }
        
        b[ii].follow = FOLLOW;
       b[ii].follow_board = FOLLOW;
        with (b[ii]) {
            a = instance_create_depth(0, 0, 0, shaker);
            
            if (follow) {
                a.var_name = "xx";
                Anim_Create(id, "yy", 0, 0, yy, (-LENGTH), 8, PAUSE);
                
                if (DURATION != -1) {
                    Anim_Create(id, "yy", 0, 0, (yy - LENGTH), (LENGTH * 2), 16, ((16 + PAUSE) + DURATION));
                }
            }
            else {
                a.var_name = "x";
                Anim_Create(id, "y", 0, 0, y, (-LENGTH), 8, PAUSE);
                
                if (DURATION != -1) {
                    Anim_Create(id, "y", 0, 0, (y - LENGTH), (LENGTH * 2), 16, ((16 + PAUSE) + DURATION));
                }
            }
            
            a.target = id;
            a.shake_distance = 2;
            a.shake_speed = 1;
            a.shake_random = 0;
            a.shake_decrease = 1;
            a.delay = (PAUSE + 8);
        }
    }
    
    a = instance_create_depth(0, 0, 0, bone_box);
    a.duration = PAUSE;
    a.x1 = ((battle_board.x - battle_board.left) );
    a.y1 = (((battle_board.y + battle_board.down) - LENGTH)+1 );
    a.x2 = ((battle_board.x + battle_board.right)-1 );
    a.y2 = ((battle_board.y + battle_board.down)-1 );
    a.follow=FOLLOW;
    audio_stop_sound(snd_exclamation);
    audio_play_sound(snd_exclamation, 0, false);
	return b;
}
///@arg pause,length,duration,*type,*follow
function Battle_MakeBoneWallLeft(){
           var PAUSE = argument[0];
    var LENGTH = argument[1];
    var DURATION = argument[2];
    var COLOR = (0 << 0);
    var FOLLOW = false;
   
    if(argument_count >= 4)
        COLOR = argument[3];
    if(argument_count >= 5)
        FOLLOW = argument[4];
   
	 var SPR_HEIGHT = max(sprite_get_height(spr_bone), sprite_get_height(spr_bone)) + 1;
    var ii = 0
    for (i = 0; i < ((battle_board.up + battle_board.down) + SPR_HEIGHT); i += SPR_HEIGHT)
    {
        ii += 1
		if(DURATION!=-1){
        b[ii] = Battle_MakeBoneH((((battle_board.x - battle_board.left) - (LENGTH / 2)) - 5), ((battle_board.y - battle_board.up) + i), LENGTH, 0, 0, COLOR, 0, 0, 0, ((DURATION + (PAUSE * 2)) + 24))
		}else{
		b[ii] = Battle_MakeBoneH((((battle_board.x - battle_board.left) - (LENGTH / 2)) - 5), ((battle_board.y - battle_board.up) + i), LENGTH, 0, 0, COLOR, 0, 0, 0, DURATION)
		}
		 b[ii].follow = FOLLOW;
       b[ii].follow_board = FOLLOW;
		with (b[ii])
        {
			a = instance_create_depth(0, 0, 0, shaker)
			if(!follow){ a.var_name = "y"
            Anim_Create(id, "x", 0, 0, x, LENGTH, 8, PAUSE)
			if(DURATION!=-1){
            Anim_Create(id, "x", 0, 0, (x + LENGTH), ((-LENGTH) * 2), 16, ((16 + PAUSE) + DURATION))}
		}
		else{ a.var_name = "yy"
			Anim_Create(id, "xx", 0, 0, xx, LENGTH, 8, PAUSE)
			if(DURATION!=-1){
            Anim_Create(id, "xx", 0, 0, (xx + LENGTH), ((-LENGTH) * 2), 16, ((16 + PAUSE) + DURATION))}}
	
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
	a.follow=FOLLOW
    a.x1 = ((battle_board.x - battle_board.left) )
    a.y1 = ((battle_board.y - battle_board.up) )
    a.x2 = (((battle_board.x - battle_board.left) + LENGTH) )
    a.y2 = ((battle_board.y + battle_board.down)-1 )
    audio_stop_sound(snd_exclamation)
    audio_play_sound(snd_exclamation, 0, false)
    return b;
}
///@arg pause,length,duration,*type,*follow
function Battle_MakeBoneWallRight(){
  var PAUSE = argument[0];
    var LENGTH = argument[1];
    var DURATION = argument[2];
    var COLOR = (0 << 0);
    var FOLLOW = false;
   
    if(argument_count >= 4)
        COLOR = argument[3];
    if(argument_count >= 5)
        FOLLOW = argument[4];
   
	 var SPR_HEIGHT = max(sprite_get_height(spr_bone), sprite_get_height(spr_bone)) + 1;
    var ii = 0
    for (i = 0; i < ((battle_board.up + battle_board.down) + SPR_HEIGHT); i += SPR_HEIGHT)
    {
        ii += 1
		if(DURATION!=-1){
        b[ii] = Battle_MakeBoneH((((battle_board.x + battle_board.right) + (LENGTH / 2)) + 5), ((battle_board.y - battle_board.up) + i), LENGTH, 0, 0, COLOR, 0, 0, 0, ((DURATION + (PAUSE * 2)) + 24))
		}else{
		b[ii] = Battle_MakeBoneH((((battle_board.x + battle_board.right) + (LENGTH / 2)) + 5), ((battle_board.y - battle_board.up) + i), LENGTH, 0, 0, COLOR, 0, 0, 0, DURATION)
		}
		b[ii].follow = FOLLOW;
        b[ii].follow_board = FOLLOW;
        with (b[ii])
        {
			a = instance_create_depth(0, 0, 0, shaker)
			if(!follow){a.var_name = "y"
            Anim_Create(id, "x", 0, 0, x, (-LENGTH), 8, PAUSE)
			if(DURATION!=-1){
            Anim_Create(id, "x", 0, 0, (x - LENGTH), (LENGTH * 2), 16, ((16 + PAUSE) + DURATION))}
			}
			else{a.var_name = "yy"
				Anim_Create(id, "xx", 0, 0, xx, (-LENGTH), 8, PAUSE)
			if(DURATION!=-1){
            Anim_Create(id, "xx", 0, 0, (xx - LENGTH), (LENGTH * 2), 16, ((16 + PAUSE) + DURATION))}
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
    a.x1 = ((battle_board.x + battle_board.right) -1)
    a.y1 = ((battle_board.y - battle_board.up) )
    a.x2 = ((battle_board.x + battle_board.right) - LENGTH-1)
    a.y2 = ((battle_board.y + battle_board.down) -1)
	a.follow=FOLLOW
    audio_stop_sound(snd_exclamation)
    audio_play_sound(snd_exclamation, 0, false)
    return b;
}
///@arg pause,length,duration,*type,*follow
function Battle_MakeBoneWallTop(){
 var PAUSE = argument[0];
    var LENGTH = argument[1];
    var DURATION = argument[2];
    var COLOR = (0 << 0);
    var FOLLOW = false;
    
    if(argument_count >= 4)
        COLOR = argument[3];
    if(argument_count >= 5)
        FOLLOW = argument[4];
   
	 var SPR_HEIGHT = max(sprite_get_height(spr_bone), sprite_get_height(spr_bone)) + 1;
    var ii = 0
    for (i = -3; i < ((battle_board.left + battle_board.right) + SPR_HEIGHT); i += SPR_HEIGHT)
    {
        ii += 1
		if(DURATION!=-1){
        b[ii] = Battle_MakeBoneV(((battle_board.x - battle_board.left) + i), (((battle_board.y - battle_board.up) - (LENGTH / 2)) - 5), LENGTH, 0, 0, COLOR, 0, 0, 0, ((DURATION + (PAUSE * 2)) + 24))
		}else{
		b[ii] = Battle_MakeBoneV(((battle_board.x - battle_board.left) + i), (((battle_board.y - battle_board.up) - (LENGTH / 2)) - 5), LENGTH, 0, 0, COLOR, 0, 0, 0, DURATION)
		}
		b[ii].follow = FOLLOW;
        b[ii].follow_board = FOLLOW;
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
    a.x1 = ((battle_board.x - battle_board.left) )
    a.y1 = (((battle_board.y - battle_board.up) + LENGTH))
    a.x2 = ((battle_board.x + battle_board.right)-1 )
    a.y2 = (battle_board.y - battle_board.up)
	a.follow=FOLLOW
    audio_stop_sound(snd_exclamation)
    audio_play_sound(snd_exclamation, 0, false)
    return b;
}
/// @arg rotatespeed,radius,type,pause,duration
function Battle_MakeBoneWallRound() {
    var duration = -1;
    var rotateSpeed = argument[0];
    var radius = argument[1];
    var type = argument[2];
    var pause = argument[3];
    
    if (argument_count > 4) {
        duration = argument[4];
    }
    
    var bone = Makebonecircle(round((battle_board.down + battle_board.right + battle_board.left + battle_board.up) / 22), 0, type, 0, 1, rotateSpeed, 0, battle_board.x, battle_board.y, (battle_board.down + battle_board.right + battle_board.left + battle_board.up) / 2, (battle_board.down + battle_board.right + battle_board.left + battle_board.up) / 2, 0, 0);
    
    Anim_Create(bone, "length", 0, 0, 0, 2 * (bone.size_x - radius - 5), 16, pause);
        
    if (duration != -1) {
        Anim_Create(bone, "length", 0, 0, 2 * (bone.size_x - radius - 5), -2 * (bone.size_x - radius - 5), 16, (16 + pause + duration));
    }
    
  
    
    var boneBox = instance_create_depth(0, 0, 0, bone_box_round);
    boneBox.duration = pause;
    boneBox.gap = radius;
    
    audio_stop_sound(snd_exclamation);
    audio_play_sound(snd_exclamation, 0, false);
    
    return bone;
}