if (place_meeting(x, y, battle_soul_yellow_bullet) && type == 4) {
    var obj = instance_place(x, y, battle_soul_yellow_bullet);
    instance_destroy(obj);
    instance_destroy();
}
if ((x < -sprite_width || x > room_width + sprite_width || y < -sprite_height || y > room_height + sprite_height) && _beam_alpha<=0) {
    instance_destroy();
    if (instance_exists(_inst)) instance_destroy(_inst);
}
