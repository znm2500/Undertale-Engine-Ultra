event_inherited();
for (var i = 0; i < sprite_get_number(sprite_index); i++) {
    idle_sprite[i] = sprite_index;
    idle_image[i] = i;
    idle_speed[i] = 0;
    talk_sprite[i] = sprite_index;
    talk_image[i] = i;
    talk_speed[i] = 0;
}