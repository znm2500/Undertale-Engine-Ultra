/// @desc Core Typer Drawing Loop
// 1. 灵魂选择器绘制 (仅在非 GUI 模式下)
if (!_gui && _choice != -1) {
    if (array_length(_choice_x) > _choice && array_length(_choice_y) > _choice) {
        draw_sprite_ext(spr_battle_soul, 0, x + _choice_x[_choice], y + _choice_y[_choice], 1, 1, 0, c_red, 1);
    }
}

// 2. 遍历所有字符数据
var list_size = array_length(_char_data_list);
for (var i = 0; i < list_size; i++) {
    var char_data = _char_data_list[i];
    if (char_data.gui) continue;
    // --- 准备绘制坐标 ---
    var _base_x = x + char_data._xUnit[0] * char_data._deltaX + char_data._yUnit[0] * char_data._deltaY;
    var _base_y = y + char_data._xUnit[1] * char_data._deltaX + char_data._yUnit[1] * char_data._deltaY;
    // --- 逻辑更新：震动效果 ---
    switch (char_data.effect) {
    case - 1 : char_data._offset_x[0] = 0;
        char_data._offset_y[0] = 0;
        break;
    case 0:
        // 普通震动
        if (_effect_shook) {
            char_data._offset_x[0] = random_range( - 1, 1);
            char_data._offset_y[0] = random_range( - 1, 1);
        }
        break;
    case 1:
        // RGB Glitch 震动
        if (_effect_shook) {
            for (var j = 0; j < 3; j++) {
                char_data._offset_x[j] = random_range( - 2, 2);
                char_data._offset_y[j] = random_range( - 2, 2);
            }
        }
        break;
    case 2:
        // 正弦波位移
        var _wave_order = char_data.order % 10;
        if (array_length(torder) > _wave_order) {
            char_data._offset_x[0] = floor(lengthdir_x(1.5, torder[_wave_order]));
            char_data._offset_y[0] = floor(lengthdir_y(1.5, torder[_wave_order]));
        }
        break;
    }

    // --- 逻辑更新：彩虹色 ---
    if (char_data.rainbow) {
        char_data.color_tick++; // 增量更新
        var ct = char_data.color_tick;
        var tw = string_width(char_data.text);
        var th = string_height(char_data.text);

        // 更新文字四角颜色 (HSV)
        char_data.color_text[0] = make_color_hsv((_base_x + ct) % 255, 255, 255);
        char_data.color_text[1] = make_color_hsv((_base_x + ct + tw) % 255, 255, 255);
        char_data.color_text[2] = make_color_hsv((_base_y + ct) % 255, 255, 255);
        char_data.color_text[3] = make_color_hsv((_base_y + ct + th) % 255, 255, 255);

        // 更新阴影四角颜色 (降低亮度)
        for (var k = 0; k < 4; k++) {
            var col = char_data.color_text[k];
            char_data.color_shadow[k] = make_color_hsv(color_get_hue(col), 128, 128);
        }
    }

    // --- 逻辑更新：物品栏裁剪 (Battle Board Clip) ---
    if (char_data.show_item && instance_exists(battle_board)) {

        var _yy = y + char_data._xUnit[1] * char_data._deltaX + char_data._yUnit[1] * char_data._deltaY;
        var _top = battle_board.y - battle_board.up + 5;
        var _bottom = _top + 80; // 64+16
        var inside = (round(_yy) >= _top && round(_yy) <= _bottom);
        if (!char_data._processed) {
            if (!inside) char_data.alpha = 0;
        }
        var target_alpha = inside ? 1 : 0;
        if (char_data.alpha != target_alpha) {
            Anim_Create(char_data, "alpha", 0, 0, char_data.alpha, target_alpha - char_data.alpha, 6);
        }
        char_data._processed = true;

    }
    // --- 设置目标 Surface ---
    var has_surface = surface_exists(char_data.surface_target);
    if (has_surface) surface_set_target(char_data.surface_target);

    draw_set_halign(char_data.halign);
    draw_set_valign(char_data.valign);

    if (char_data.effect != 1) {
        // 普通模式绘制 (文字 + 阴影 + 描边)
        if (font_exists(char_data.font)) {
            draw_set_font(char_data.font);
            var dx = _base_x + char_data._offset_x[0];
            var dy = _base_y + char_data._offset_y[0];

            // 1. 绘制阴影
            if (char_data.shadow) {
                draw_text_transformed_color(dx + char_data.shadow_x * char_data.scale_x, dy + char_data.shadow_y * char_data.scale_y, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, char_data.color_shadow[0], char_data.color_shadow[1], char_data.color_shadow[3], char_data.color_shadow[2], char_data.alpha_shadow * char_data.alpha);
            }

            // 2. 绘制描边
            if (char_data.outline) {
                var XO_OH = lengthdir_x(1, char_data.angle);
                var YO_OH = lengthdir_y(1, char_data.angle);
                var XO_OV = lengthdir_x(1, char_data.angle - 90);
                var YO_OV = lengthdir_y(1, char_data.angle - 90);
                for (var p = 1; p <= char_data.scale_x; p++) {
                    draw_text_transformed_color(dx + p * XO_OH, dy + p * YO_OH, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, char_data.color_outline[0], char_data.color_outline[1], char_data.color_outline[3], char_data.color_outline[2], char_data.alpha_outline * char_data.alpha);
                    draw_text_transformed_color(dx - p * XO_OH, dy - p * YO_OH, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, char_data.color_outline[0], char_data.color_outline[1], char_data.color_outline[3], char_data.color_outline[2], char_data.alpha_outline * char_data.alpha);
                    draw_text_transformed_color(dx + p * XO_OV, dy + p * YO_OV, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, char_data.color_outline[0], char_data.color_outline[1], char_data.color_outline[3], char_data.color_outline[2], char_data.alpha_outline * char_data.alpha);
                    draw_text_transformed_color(dx - p * XO_OV, dy - p * YO_OV, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, char_data.color_outline[0], char_data.color_outline[1], char_data.color_outline[3], char_data.color_outline[2], char_data.alpha_outline * char_data.alpha);
                }
            }

            // 3. 绘制主体文字
            draw_text_transformed_color(dx, dy, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, char_data.color_text[0], char_data.color_text[1], char_data.color_text[3], char_data.color_text[2], char_data.alpha_text * char_data.alpha);
        }

        // 4. 绘制 Sprite
        if (sprite_exists(char_data.sprite)) {
            draw_sprite_ext(char_data.sprite, char_data.sprite_image, _base_x + char_data._offset_x[0], _base_y + char_data._offset_y[0], char_data.scale_x, char_data.scale_y, char_data.angle, char_data.color_text[0], char_data.alpha_text * char_data.alpha);
        }
    } else {
        if (font_exists(char_data.font)) {
            draw_set_font(char_data.font);
        }

        // 基础偏移坐标
        var dx = _base_x;
        var dy = _base_y;

        // --- 开启全色散模式 ---
        gpu_set_blendmode(bm_add);

        var colors = [c_red, c_blue, c_lime]; // RGB 三通道参考色
        // 循环绘制三次通道
        for (var m = 2; m >= 0; m--) {
            var m_col = colors[m];
            var cur_x = dx + char_data._offset_x[m];
            var cur_y = dy + char_data._offset_y[m];
            var _at = char_data.alpha_text * char_data.alpha;

            // 1. 通道内阴影
            if (char_data.shadow) {
                draw_text_transformed_color(cur_x + char_data.shadow_x * char_data.scale_x, cur_y + char_data.shadow_y * char_data.scale_y, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, Blend_Color(char_data.color_shadow[0], m_col), Blend_Color(char_data.color_shadow[1], m_col), Blend_Color(char_data.color_shadow[3], m_col), Blend_Color(char_data.color_shadow[2], m_col), char_data.alpha_shadow * char_data.alpha);
            }

            // 2. 通道内描边 (Outline)
            if (char_data.outline) {
                var XO_OH = lengthdir_x(1, char_data.angle);
                var YO_OH = lengthdir_y(1, char_data.angle);
                var XO_OV = lengthdir_x(1, char_data.angle - 90);
                var YO_OV = lengthdir_y(1, char_data.angle - 90);

                for (var p = 1; p <= char_data.scale_x; p++) {
                    var out_col0 = Blend_Color(char_data.color_outline[0], m_col);
                    var out_col1 = Blend_Color(char_data.color_outline[1], m_col);
                    var out_col2 = Blend_Color(char_data.color_outline[2], m_col);
                    var out_col3 = Blend_Color(char_data.color_outline[3], m_col);
                    var _ao = char_data.alpha_outline * char_data.alpha;

                    draw_text_transformed_color(cur_x + p * XO_OH, cur_y + p * YO_OH, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, out_col0, out_col1, out_col3, out_col2, _ao);
                    draw_text_transformed_color(cur_x - p * XO_OH, cur_y - p * YO_OH, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, out_col0, out_col1, out_col3, out_col2, _ao);
                    draw_text_transformed_color(cur_x + p * XO_OV, cur_y + p * YO_OV, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, out_col0, out_col1, out_col3, out_col2, _ao);
                    draw_text_transformed_color(cur_x - p * XO_OV, cur_y - p * YO_OV, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, out_col0, out_col1, out_col3, out_col2, _ao);
                }
            }

            // 3. 通道内主体文字
            draw_text_transformed_color(cur_x, cur_y, char_data.text, char_data.scale_x, char_data.scale_y, char_data.angle, Blend_Color(char_data.color_text[0], m_col), Blend_Color(char_data.color_text[1], m_col), Blend_Color(char_data.color_text[3], m_col), Blend_Color(char_data.color_text[2], m_col), _at);
        }
        gpu_set_blendmode(bm_normal);

    }

    if (has_surface) surface_reset_target();
}

// 翻转震动标志，确保下一帧产生随机位移
_effect_shook +=global.delta_time_factor;
if(_effect_shook>=2)_effect_shook=0;
