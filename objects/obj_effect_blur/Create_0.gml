draw_set_color(c_white)
depth=DEPTH_UI.FADER+1

uni_resolution_hoz = shader_get_uniform(shd_gaussian_horizontal, "resolution")
uni_resolution_vert = shader_get_uniform(shd_gaussian_vertical, "resolution")
var_resolution_x = 640
var_resolution_y = 480
uni_blur_amount_hoz = shader_get_uniform(shd_gaussian_vertical, "blur_amount")
uni_blur_amount_vert = shader_get_uniform(shd_gaussian_horizontal, "blur_amount")
var_blur_amount = 2

surface_width = window_get_width()
surface_height = window_get_height()
final_surface = application_surface
surf = surface_create(surface_width, surface_height)

duration = 30
alarm[0] = 1