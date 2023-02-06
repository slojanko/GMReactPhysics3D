matrix_set(matrix_world, GetTransform(ground));
vertex_submit(vb_plane, pr_trianglelist, -1);

for(var i = 0; i < cube_count; i++) {
	matrix_set(matrix_world, GetTransform(box_list[| i]));
	vertex_submit(vb_plane, pr_trianglelist, sprite_get_texture(crate_spr, 0));
}

matrix_set(matrix_world, matrix_build_identity());