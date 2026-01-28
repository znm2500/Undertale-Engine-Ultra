///@desc Group & Macro Initialization

// --- 将 ds_map 替换为 Struct ---
// 直接使用字面量初始化，或者用变量名[$ "键"]赋值
_map_macro = {
    "true": true,
    "false": false,
    
    "DIR.UP": DIR.UP,
    "DIR.DOWN": DIR.DOWN,
    "DIR.LEFT": DIR.LEFT,
    "DIR.RIGHT": DIR.RIGHT,
    
    "FONT.DIALOG": 0,
    "FONT.MENU": 1,
    "FONT.BATTLE": 2,
    
    "VOICE.NULL": -1,
    "VOICE.DEFAULT": 0,
    "VOICE.TYPER": 1,
    "voice.asgore": 2
};

// --- 字体组配置 (使用多维数组) ---
// 格式: _group_font[font_id, type_id] 
// type_id: 0 为 ASCII(英文), 1 为 非ASCII(中日韩等)

// Dialog Font
_group_font[0] = [font_determination_mono, font_menu];
_group_font_scale_x[0] = [1, 1];
_group_font_scale_y[0] = [1, 1];
_group_font_space_x[0] = [0, 1];
_group_font_space_y[0] = 0;

// Menu Font
_group_font[1] = [font_determination_mono, font_menu];
_group_font_scale_x[1] = [1, 1];
_group_font_scale_y[1] = [1, 1];
_group_font_space_x[1] = [0, 1];
_group_font_space_y[1] = 0;

// Sans / Battle Font
_group_font[2] = [font_sans, font_sans];
_group_font_scale_x[2] = [1, 1];
_group_font_scale_y[2] = [1, 1];
_group_font_space_x[2] = [1, 1];
_group_font_space_y[2] = 3;

// --- 语音组配置 ---
// 使用数组嵌套，支持一个角色拥有多种随机音效
_group_voice[0] = [snd_text_voice_default];
_group_voice[1] = [snd_text_voice_typer];
_group_voice[2] = [snd_text_voice_sans];
_group_voice[3] = [snd_text_voice_toriel];

// --- 头像对象配置 ---
_group_face = [face, face_sans];