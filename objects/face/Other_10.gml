///@desc Draw
if (surface_exists(surface_target)) {
    surface_set_target(surface_target);
}
draw_self();
if (surface_exists(surface_target)) {
    surface_reset_target();
}
