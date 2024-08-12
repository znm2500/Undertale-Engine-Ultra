///@desc Draw
if (show_item) {
    if (Battle_GetMenu() == BATTLE_MENU.ITEM) {
        if (round(y) >= battle_board.y - battle_board.up - 5 + 20 - 16 && round(y) <= battle_board.y - battle_board.up - 5 + 20 + 64 + 16) {
            Anim_Create(id, "alpha", 0, 0, alpha, 1 - alpha, 7);
        } else {
            Anim_Create(id, "alpha", 0, 0, alpha, -alpha, 7);
        }
    }
}
draw_set_halign(halign);
draw_set_valign(valign);
if (surface_exists(surface_target)) {
    surface_set_target(surface_target)
}
if (effect != 1) {
    if (font_exists(font)) {
        draw_set_font(font);
        if (shadow) {
            draw_text_transformed_color(x + _offset_x[0] + shadow_x * scale_x, y + _offset_y[0] + shadow_y * scale_y, text, scale_x, scale_y, angle, color_shadow[0], color_shadow[1], color_shadow[3], color_shadow[2], alpha_shadow * alpha);
        }
        if (outline) {
            var XO_OH = lengthdir_x(1, angle);
            var YO_OH = lengthdir_y(1, angle);
            var XO_OV = lengthdir_x(1, angle - 90);
            var YO_OV = lengthdir_y(1, angle - 90);
            var proc = 0;
            repeat(scale_x) {
                proc += 1;

                draw_text_transformed_color(x + _offset_x[0] + proc * XO_OH, y + _offset_y[0] + proc * YO_OH, text, scale_x, scale_y, angle, color_outline[0], color_outline[1], color_outline[3], color_outline[2], alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[0] - proc * XO_OH, y + _offset_y[0] - proc * YO_OH, text, scale_x, scale_y, angle, color_outline[0], color_outline[1], color_outline[3], color_outline[2], alpha_outline * alpha);
            }
            proc = 0;
            repeat(scale_y) {
                proc += 1;
                draw_text_transformed_color(x + _offset_x[0] + proc * XO_OV, y + _offset_y[0] + proc * YO_OV, text, scale_x, scale_y, angle, color_outline[0], color_outline[1], color_outline[3], color_outline[2], alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[0] - proc * XO_OV, y + _offset_y[0] - proc * YO_OV, text, scale_x, scale_y, angle, color_outline[0], color_outline[1], color_outline[3], color_outline[2], alpha_outline * alpha);
            }
        }
        draw_text_transformed_color(x + _offset_x[0], y + _offset_y[0], text, scale_x, scale_y, angle, color_text[0], color_text[1], color_text[3], color_text[2], alpha_text * alpha);
    }
    if (sprite_exists(sprite)) {
        draw_sprite_ext(sprite, sprite_image, x + _offset_x[0], y + _offset_y[0], scale_x, scale_y, angle, color_text[0], alpha_text * alpha);
    }
} else {
    gpu_set_blendmode(bm_add);
    if (font_exists(font)) {
        draw_set_font(font);
        if (shadow) {
            draw_text_transformed_color(x + _offset_x[2] + shadow_x * scale_x, y + _offset_y[2] + shadow_y * scale_y, text, scale_x, scale_y, angle, Blend_Color(color_shadow[0], make_color_rgb(0, 255, 0)), Blend_Color(color_shadow[1], make_color_rgb(0, 255, 0)), Blend_Color(color_shadow[3], make_color_rgb(0, 255, 0)), Blend_Color(color_shadow[2], make_color_rgb(0, 255, 0)), alpha_shadow * alpha);
            draw_text_transformed_color(x + _offset_x[1] + shadow_x * scale_x, y + _offset_y[1] + shadow_y * scale_y, text, scale_x, scale_y, angle, Blend_Color(color_shadow[0], c_blue), Blend_Color(color_shadow[1], c_blue), Blend_Color(color_shadow[3], c_blue), Blend_Color(color_shadow[2], c_blue), alpha_shadow * alpha);
            draw_text_transformed_color(x + _offset_x[0] + shadow_x * scale_x, y + _offset_y[0] + shadow_y * scale_y, text, scale_x, scale_y, angle, Blend_Color(color_shadow[0], c_red), Blend_Color(color_shadow[1], c_red), Blend_Color(color_shadow[3], c_red), Blend_Color(color_shadow[2], c_red), alpha_shadow * alpha);

        }
        if (outline) {
            var proc = 0;
            var XO_OH = lengthdir_x(1, angle);
            var YO_OH = lengthdir_y(1, angle);
            var XO_OV = lengthdir_x(1, angle - 90);
            var YO_OV = lengthdir_y(1, angle - 90);
            repeat(scale_x) {
                proc += 1;
                draw_text_transformed_color(x + _offset_x[2] + proc * XO_OH, y + _offset_y[2] + proc * YO_OH, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[1], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[3], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[2], make_color_rgb(0, 255, 0)), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[1] + proc * XO_OH, y + _offset_y[1] + proc * YO_OH, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_blue), Blend_Color(color_outline[1], c_blue), Blend_Color(color_outline[3], c_blue), Blend_Color(color_outline[2], c_blue), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[0] + proc * XO_OH, y + _offset_y[0] + proc * YO_OH, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_red), Blend_Color(color_outline[1], c_red), Blend_Color(color_outline[3], c_red), Blend_Color(color_outline[2], c_red), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[2] - proc * XO_OH, y + _offset_y[2] - proc * YO_OH, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[1], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[3], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[2], make_color_rgb(0, 255, 0)), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[1] - proc * XO_OH, y + _offset_y[1] - proc * YO_OH, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_blue), Blend_Color(color_outline[1], c_blue), Blend_Color(color_outline[3], c_blue), Blend_Color(color_outline[2], c_blue), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[0] - proc * XO_OH, y + _offset_y[0] - proc * YO_OH, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_red), Blend_Color(color_outline[1], c_red), Blend_Color(color_outline[3], c_red), Blend_Color(color_outline[2], c_red), alpha_outline * alpha);

            }
            proc = 0;
            repeat(scale_y) {
                proc += 1;
                draw_text_transformed_color(x + _offset_x[2] + proc * XO_OV, y + _offset_y[2] + proc * YO_OV, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[1], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[3], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[2], make_color_rgb(0, 255, 0)), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[1] + proc * XO_OV, y + _offset_y[1] + proc * YO_OV, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_blue), Blend_Color(color_outline[1], c_blue), Blend_Color(color_outline[3], c_blue), Blend_Color(color_outline[2], c_blue), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[0] + proc * XO_OV, y + _offset_y[0] + proc * YO_OV, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_red), Blend_Color(color_outline[1], c_red), Blend_Color(color_outline[3], c_red), Blend_Color(color_outline[2], c_red), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[2] - proc * XO_OV, y + _offset_y[2] - proc * YO_OV, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[1], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[3], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[2], make_color_rgb(0, 255, 0)), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[1] - proc * XO_OV, y + _offset_y[1] - proc * YO_OV, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_blue), Blend_Color(color_outline[1], c_blue), Blend_Color(color_outline[3], c_blue), Blend_Color(color_outline[2], c_blue), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x[0] - proc * XO_OV, y + _offset_y[0] - proc * YO_OV, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_red), Blend_Color(color_outline[1], c_red), Blend_Color(color_outline[3], c_red), Blend_Color(color_outline[2], c_red), alpha_outline * alpha);
            }
        }
        draw_text_transformed_color(x + _offset_x[2], y + _offset_y[2], text, scale_x, scale_y, angle, Blend_Color(color_text[0], make_color_rgb(0, 255, 0)), Blend_Color(color_text[1], make_color_rgb(0, 255, 0)), Blend_Color(color_text[3], make_color_rgb(0, 255, 0)), Blend_Color(color_text[2], make_color_rgb(0, 255, 0)), alpha_text * alpha);
        draw_text_transformed_color(x + _offset_x[1], y + _offset_y[1], text, scale_x, scale_y, angle, Blend_Color(color_text[0], c_blue), Blend_Color(color_text[1], c_blue), Blend_Color(color_text[3], c_blue), Blend_Color(color_text[2], c_blue), alpha_text * alpha);
        draw_text_transformed_color(x + _offset_x[0], y + _offset_y[0], text, scale_x, scale_y, angle, Blend_Color(color_text[0], c_red), Blend_Color(color_text[1], c_red), Blend_Color(color_text[3], c_red), Blend_Color(color_text[2], c_red), alpha_text * alpha);
    }
    if (sprite_exists(sprite)) {
        draw_sprite_ext(sprite, sprite_image, x + _offset_x[2], y + _offset_y[2], scale_x, scale_y, angle, Blend_Color(color_text[0], make_color_rgb(0, 255, 0)), alpha_text * alpha);
        draw_sprite_ext(sprite, sprite_image, x + _offset_x[1], y + _offset_y[1], scale_x, scale_y, angle, Blend_Color(color_text[0], c_blue), alpha_text * alpha);
        draw_sprite_ext(sprite, sprite_image, x + _offset_x[0], y + _offset_y[0], scale_x, scale_y, angle, Blend_Color(color_text[0], c_red), alpha_text * alpha);
    }
    gpu_set_blendmode(bm_normal);
}
if (surface_exists(surface_target)) {
    surface_reset_target();
}