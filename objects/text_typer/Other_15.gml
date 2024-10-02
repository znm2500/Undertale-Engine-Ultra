///@desc Group & Macro
ds_map_add(_map_macro,"true",true);
ds_map_add(_map_macro,"false",false);

ds_map_add(_map_macro,"DIR.UP",DIR.UP);
ds_map_add(_map_macro,"DIR.DOWN",DIR.DOWN);
ds_map_add(_map_macro,"DIR.LEFT",DIR.LEFT);
ds_map_add(_map_macro,"DIR.RIGHT",DIR.RIGHT);

ds_map_add(_map_macro,"FONT.DIALOG",0);
ds_map_add(_map_macro,"FONT.MENU",1);
ds_map_add(_map_macro,"FONT.BATTLE",2);

ds_map_add(_map_macro,"VOICE.NULL",-1);
ds_map_add(_map_macro,"VOICE.DEFAULT",0);
ds_map_add(_map_macro,"VOICE.TYPER",1);
ds_map_add(_map_macro,"voice.asgore",2)

_group_font[0,0]=font_determination_mono;
_group_font_scale_x[0,0]=1;
_group_font_scale_y[0,0]=1;
_group_font_space_x[0,0]=0;
_group_font[0,1]=font_menu
_group_font_scale_x[0,1]=1
_group_font_scale_y[0,1]=1
_group_font_space_x[0,1]=1
_group_font_space_y[0]=0;

_group_font[1,0]=font_determination_mono;
_group_font_scale_x[1,0]=1;
_group_font_scale_y[1,0]=1;
_group_font_space_x[1,0]=0;
_group_font[1,1]=font_menu
_group_font_scale_x[1,1]=1
_group_font_scale_y[1,1]=1
_group_font_space_x[1,1]=1
_group_font_space_y[1]=0;

_group_font[2,0]=font_sans
_group_font_scale_x[2,0]=1
_group_font_scale_y[2,0]=1
_group_font_space_x[2,0]=1
_group_font[2,1]=font_sans
_group_font_scale_x[2,1]=1
_group_font_scale_y[2,1]=1
_group_font_space_x[2,1]=1
_group_font_space_y[2]=3


_group_voice[0,0]=snd_text_voice_default;
_group_voice[1,0]=snd_text_voice_typer;
_group_voice[2,0]=snd_text_voice_sans;
_group_voice[3,0]=snd_text_voice_asgore;
_group_face[0]=face;
_group_face[1]=face_sans;