if (!surface_exists(depth_surface)) {
    depth_surface = surface_create(2048, 2048, surface_r32float);
}

// Get depth
shader_set(shadow_shd);
surface_set_target_ext(0, depth_surface);
draw_clear_alpha(#ffffff, 1.0);
Camera.RefreshLight();

draw_scene();

matrix_set(matrix_world, matrix_build_identity());
surface_reset_target();
shader_reset();

// Do stuff
shader_set(shadow_forward_shd);
Camera.RefreshMatrices();
Camera.RefreshLight(shadow_forward_shd);
draw_clear_alpha(#3366cc, 1.0);

sampler = shader_get_sampler_index(shadow_forward_shd, "s_depth")
texture_set_stage(sampler, surface_get_texture(depth_surface));

draw_scene();

matrix_set(matrix_world, matrix_build_identity());
shader_reset();