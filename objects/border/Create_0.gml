_enabled=false;
_sprite=-1;
_sprite_previous=-1;
_alpha=1;
uni_resolution_hoz = shader_get_uniform(shd_gaussian_horizontal, "resolution")
uni_resolution_vert = shader_get_uniform(shd_gaussian_vertical, "resolution")
var_resolution_x = 640
var_resolution_y = 480
uni_blur_amount_hoz = shader_get_uniform(shd_gaussian_vertical, "blur_amount")
uni_blur_amount_vert = shader_get_uniform(shd_gaussian_horizontal, "blur_amount")
var_blur_amount = 1

surface_width = window_get_width()
surface_height = window_get_height()

surf = surface_create(surface_width, surface_height)
blur=0