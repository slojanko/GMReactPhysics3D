shader_set(surface_shd);
matrix_set(matrix_world, matrix_build(0, 0, 5, 0, 0, 0, 1, 1, 1));
vertex_submit(ground_model, pr_trianglelist, ground_texture);

if (updated_once) {
	for(var i = box_count - 1; i >= 0; i--) {
		matrix_set(matrix_world, shared_array[i]);
		vertex_submit(box_model, pr_trianglelist, box_texture);
	}
}

matrix_set(matrix_world, matrix_build_identity());
shader_reset();