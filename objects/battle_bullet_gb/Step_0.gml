switch(state)
{
    case 0:
    {
        var _blaster = [blaster.x, blaster.y, blaster.image_angle];
        var _target = [target_x, target_y, target_angle];
        var _timer = timer_move;
        if(charge_sound){
        audio_play_sound(snd_gb_charge, 0, 0);
		charge_sound=0;}
        // Move blaster to assigned destination
        if (_timer < time_move)
        {
            for (var i = 0; i < 3; i++)
            {
                _blaster[i] += (_target[i] - _blaster[i]) * (5 / time_move) * global.delta_time_factor;
                _blaster[i] += sign(_target[i] - _blaster[i]) / 2 * global.delta_time_factor;
                if (abs(_blaster[i] - _target[i]) < 1.5 * global.delta_time_factor) _blaster[i] = _target[i];
            }
            _timer +=global.delta_time_factor;
        }
        
        if ((_timer >= time_move) || (!time_move))
        {
            // Wait till blast
            state = 1;
            _timer = 0;
            for (var i = 0; i < 3; i++)
                _blaster[i] = _target[i];
            
            alarm[0] = max(1, time_delay)/global.delta_time_factor;
        }
        
        with (blaster)
        {
            x = _blaster[0];
            y = _blaster[1];
            image_angle = _blaster[2];
        }
        
        target_x = _target[0];
        target_y = _target[1];
        target_angle = _target[2];
        timer_move = _timer;
        break;
    }

    case 2:
    {
        state = 3;
		_blaster_yscale=blaster.image_yscale;
        alarm[0] = 8/global.delta_time_factor;
        alarm[1] = 9/global.delta_time_factor;
        break;
    }

    case 3:
    {
        blaster.image_yscale-=blaster.image_yscale*0.025*global.delta_time_factor;
        break;
    }

    case 4:
    {
        var _blaster = [blaster.x, blaster.y, blaster.image_angle, blaster.image_xscale, blaster.image_yscale, blaster.direction, blaster.speed],
            _beam = [x, y, image_angle, image_xscale, image_yscale, image_alpha];
        
        var _timer = [timer_blast, timer_exit];
        
        _blaster[5] = _blaster[2] - 180;
        with (blaster)
        {
            var _rx = 0, _ry = 0;
            
            if (_blaster[6] != 0)
            {
                _blaster[0] += lengthdir_x(_blaster[6] * global.delta_time_factor, _blaster[5]);
                _blaster[1] += lengthdir_y(_blaster[6] * global.delta_time_factor, _blaster[5]);
            }
            
            var _spr_width = (sprite_get_width(sprite_index) / 2);
            _beam[2] = _blaster[2];
            _beam[0] = _blaster[0] + lengthdir_x(_spr_width * _blaster[3], _beam[2]) + _rx;
            _beam[1] = _blaster[1] + lengthdir_y(_spr_width * _blaster[3], _beam[2]) + _ry;
        }
        
        if (_timer[0] == 0)
        {	
            if (_blaster[4] >= 2)
            {
                Camera_Shake(5, 5, 1, 1, 0.5, 0.5, true, true);
            }
			if(blast_sound){
            audio_play_sound(snd_gb_release, 0, 0);
			blast_sound=0;
			}
        }
        
        for (var i = 0; i < 2; i++) _timer[i] += global.delta_time_factor;
        _beam[3] += _blaster[6] / 20 * global.delta_time_factor;

        if (_timer[1] >= time_stay && _timer[1] < (time_stay + 10)) _blaster[6] += 0.5 * global.delta_time_factor;
        else if (_timer[1] > (time_stay + 10)) _blaster[6] += 2 * global.delta_time_factor;

        if (_timer[0] < 10)
            _beam[4] += abs(_blaster[4]) / 5 * global.delta_time_factor;
        
        if (_timer[0] >= 10 + time_blast)
        {
            _beam[4] *= power(0.8, global.delta_time_factor / 2);
            _beam[5] -= 0.05 * global.delta_time_factor;
            
            if (_beam[4] <= 0.05)
                destroy = true;
        }
        
        if ((_beam[5] >= 0.8 && _beam[4] > 0.05) && place_meeting(x, y, battle_soul))
            Battle_CallSoulEventBulletCollision();
        
        var _cam = view_camera[0],
            _view_x = camera_get_view_x(_cam),
            _view_y = camera_get_view_y(_cam),
            _view_w = camera_get_view_width(_cam),
            _view_h = camera_get_view_height(_cam);
        
        var _bb_u = sprite_get_bbox_top(blaster.sprite_index) * blaster.image_yscale,
            _bb_d = sprite_get_bbox_bottom(blaster.sprite_index) * blaster.image_yscale,
            _bb_l = sprite_get_bbox_left(blaster.sprite_index) * blaster.image_xscale,
            _bb_r = sprite_get_bbox_right(blaster.sprite_index) * blaster.image_xscale;
        if (destroy && !point_in_rectangle(blaster.x, blaster.y, _view_x - _bb_l, _view_y - _bb_u, _view_w + _bb_r, _view_h + _bb_d))
        {
            speed = 0;
            if (timer_exit >= time_stay)
                instance_destroy();
        }	
            
        #region Reassign variable value back from local vars
        with (blaster)
        {
            x = _blaster[0];
            y = _blaster[1];
            image_angle = _blaster[2];
            image_xscale = _blaster[3];
            image_yscale = _blaster[4];
            direction = _blaster[5];
            speed = _blaster[6];
        }
        
        x = _beam[0];
        y = _beam[1];
        image_angle = _beam[2];
        image_xscale = _beam[3];
        image_yscale = _beam[4];
        image_alpha = _beam[5];
        
        timer_blast = _timer[0];
        timer_exit = _timer[1];
        #endregion
        break;
    }
}