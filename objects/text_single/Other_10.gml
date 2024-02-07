///@desc Draw
if (surface_exists(surface_target)) {
    surface_set_target(surface_target)
}
if (effect != 1) {
    if (font_exists(font)) {
        draw_set_font(font);
        if (shadow) {
            draw_text_transformed_color(x + _offset_x + shadow_x * scale_x, y + _offset_y + shadow_y * scale_y, text, scale_x, scale_y, angle, color_shadow[0], color_shadow[1], color_shadow[3], color_shadow[2], alpha_shadow * alpha);
        }
        if (outline) {
            var proc = 0;
            repeat(scale_x) {
                proc += 1;

                draw_text_transformed_color(x + _offset_x + proc, y + _offset_y, text, scale_x, scale_y, angle, color_outline[0], color_outline[1], color_outline[3], color_outline[2], alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x - proc, y + _offset_y, text, scale_x, scale_y, angle, color_outline[0], color_outline[1], color_outline[3], color_outline[2], alpha_outline * alpha);
            }
            proc = 0;
            repeat(scale_y) {
                proc += 1;
                draw_text_transformed_color(x + _offset_x, y + _offset_y + proc, text, scale_x, scale_y, angle, color_outline[0], color_outline[1], color_outline[3], color_outline[2], alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x, y + _offset_y - proc, text, scale_x, scale_y, angle, color_outline[0], color_outline[1], color_outline[3], color_outline[2], alpha_outline * alpha);
            }
        }
        draw_text_transformed_color(x + _offset_x, y + _offset_y, text, scale_x, scale_y, angle, color_text[0], color_text[1], color_text[3], color_text[2], alpha_text * alpha);
    }
    if (sprite_exists(sprite)) {
        draw_sprite_ext(sprite, sprite_image, x + _offset_x, y + _offset_y, scale_x, scale_y, angle, color_text[0], alpha_text * alpha);
    }
} else {
    gpu_set_blendmode(bm_add) if (font_exists(font)) {
        draw_set_font(font);
        if (shadow) {
            draw_text_transformed_color(x + _offset_xxx + shadow_x * scale_x, y + _offset_yyy + shadow_y * scale_y, text, scale_x, scale_y, angle, Blend_Color(color_shadow[0], make_color_rgb(0, 255, 0)), Blend_Color(color_shadow[1], make_color_rgb(0, 255, 0)), Blend_Color(color_shadow[3], make_color_rgb(0, 255, 0)), Blend_Color(color_shadow[2], make_color_rgb(0, 255, 0)), alpha_shadow * alpha);
            draw_text_transformed_color(x + _offset_xx + shadow_x * scale_x, y + _offset_yy + shadow_y * scale_y, text, scale_x, scale_y, angle, Blend_Color(color_shadow[0], c_blue), Blend_Color(color_shadow[1], c_blue), Blend_Color(color_shadow[3], c_blue), Blend_Color(color_shadow[2], c_blue), alpha_shadow * alpha);
            draw_text_transformed_color(x + _offset_x + shadow_x * scale_x, y + _offset_y + shadow_y * scale_y, text, scale_x, scale_y, angle, Blend_Color(color_shadow[0], c_red), Blend_Color(color_shadow[1], c_red), Blend_Color(color_shadow[3], c_red), Blend_Color(color_shadow[2], c_red), alpha_shadow * alpha);

        }
        if (outline) {
            var proc = 0;
            repeat(scale_x) {
                proc += 1;
                draw_text_transformed_color(x + _offset_xxx + proc, y + _offset_yyy, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[1], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[3], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[2], make_color_rgb(0, 255, 0)), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_xx + proc, y + _offset_yy, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_blue), Blend_Color(color_outline[1], c_blue), Blend_Color(color_outline[3], c_blue), Blend_Color(color_outline[2], c_blue), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x + proc, y + _offset_y, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_red), Blend_Color(color_outline[1], c_red), Blend_Color(color_outline[3], c_red), Blend_Color(color_outline[2], c_red), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_xxx - proc, y + _offset_yyy, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[1], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[3], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[2], make_color_rgb(0, 255, 0)), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_xx - proc, y + _offset_yy, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_blue), Blend_Color(color_outline[1], c_blue), Blend_Color(color_outline[3], c_blue), Blend_Color(color_outline[2], c_blue), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x - proc, y + _offset_y, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_red), Blend_Color(color_outline[1], c_red), Blend_Color(color_outline[3], c_red), Blend_Color(color_outline[2], c_red), alpha_outline * alpha);

            }
            proc = 0;
            repeat(scale_y) {
                proc += 1;
                draw_text_transformed_color(x + _offset_xxx, y + _offset_yyy + proc, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[1], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[3], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[2], make_color_rgb(0, 255, 0)), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_xx, y + _offset_yy + proc, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_blue), Blend_Color(color_outline[1], c_blue), Blend_Color(color_outline[3], c_blue), Blend_Color(color_outline[2], c_blue), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x, y + _offset_y + proc, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_red), Blend_Color(color_outline[1], c_red), Blend_Color(color_outline[3], c_red), Blend_Color(color_outline[2], c_red), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_xxx, y + _offset_yyy - proc, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[1], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[3], make_color_rgb(0, 255, 0)), Blend_Color(color_outline[2], make_color_rgb(0, 255, 0)), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_xx, y + _offset_yy - proc, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_blue), Blend_Color(color_outline[1], c_blue), Blend_Color(color_outline[3], c_blue), Blend_Color(color_outline[2], c_blue), alpha_outline * alpha);
                draw_text_transformed_color(x + _offset_x, y + _offset_y - proc, text, scale_x, scale_y, angle, Blend_Color(color_outline[0], c_red), Blend_Color(color_outline[1], c_red), Blend_Color(color_outline[3], c_red), Blend_Color(color_outline[2], c_red), alpha_outline * alpha);
            }
        }
        draw_text_transformed_color(x + _offset_xxx, y + _offset_yyy, text, scale_x, scale_y, angle, Blend_Color(color_text[0], make_color_rgb(0, 255, 0)), Blend_Color(color_text[1], make_color_rgb(0, 255, 0)), Blend_Color(color_text[3], make_color_rgb(0, 255, 0)), Blend_Color(color_text[2], make_color_rgb(0, 255, 0)), alpha_text * alpha);
        draw_text_transformed_color(x + _offset_xx, y + _offset_yy, text, scale_x, scale_y, angle, Blend_Color(color_text[0], c_blue), Blend_Color(color_text[1], c_blue), Blend_Color(color_text[3], c_blue), Blend_Color(color_text[2], c_blue), alpha_text * alpha);
        draw_text_transformed_color(x + _offset_x, y + _offset_y, text, scale_x, scale_y, angle, Blend_Color(color_text[0], c_red), Blend_Color(color_text[1], c_red), Blend_Color(color_text[3], c_red), Blend_Color(color_text[2], c_red), alpha_text * alpha);
    }
    if (sprite_exists(sprite)) {
        draw_sprite_ext(sprite, sprite_image, x + _offset_xxx, y + _offset_yyy, scale_x, scale_y, angle, Blend_Color(color_text[0], make_color_rgb(0, 255, 0)), alpha_text * alpha);
        draw_sprite_ext(sprite, sprite_image, x + _offset_xx, y + _offset_yy, scale_x, scale_y, angle, Blend_Color(color_text[0], c_blue), alpha_text * alpha);
        draw_sprite_ext(sprite, sprite_image, x + _offset_x, y + _offset_y, scale_x, scale_y, angle, Blend_Color(color_text[0], c_red), alpha_text * alpha);
    }
    gpu_set_blendmode(bm_normal)
}
if (surface_exists(surface_target)) {
    surface_reset_target()
}