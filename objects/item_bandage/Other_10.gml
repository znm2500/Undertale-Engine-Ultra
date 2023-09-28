///@desc Use
Dialog_Add("* You re-applied the bandage."+Item_GetTextHeal(10));
Dialog_Start();

Player_Heal(10);

Item_Remove(_item_slot);

audio_play_sound(snd_item_heal,0,false);

event_inherited();