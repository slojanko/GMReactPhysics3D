if (!surface_exists(color_surface)) {
	color_surface = surface_create(window_get_width(), window_get_height(), surface_rgba32float);
}
if (!surface_exists(world_pos_surface)) {
	world_pos_surface = surface_create(window_get_width(), window_get_height(), surface_rgba32float);
}
if (!surface_exists(norm_surface)) {
	norm_surface = surface_create(window_get_width(), window_get_height(), surface_rgba32float);
}
if (!surface_exists(depth_surface)) {
	depth_surface = surface_create(window_get_width(), window_get_height(), surface_rgba32float);
}

shader_set(forward_shd);
//surface_set_target_ext(0, color_surface);
//surface_set_target_ext(1, world_pos_surface);
//surface_set_target_ext(2, norm_surface);
//surface_set_target_ext(3, depth_surface);

Camera.RefreshMatrices();
Camera.RefreshLight(forward_shd);
draw_clear_alpha(#3366cc, 1.0);

matrix_set(matrix_world, matrix_build(0, 0, 5, 0, 0, 0, 1, 1, 1));
vertex_submit(ground_model, pr_trianglelist, ground_texture);

if (updated_once) {
	for(var i = box_count - 1; i >= 0; i--) {
		matrix_set(matrix_world, shared_array[i]);
		vertex_submit(box_model, pr_trianglelist, box_texture);
	}
}

matrix_set(matrix_world, matrix_build_identity());

//surface_reset_target();
shader_reset();