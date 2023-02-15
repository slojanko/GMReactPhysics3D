var mLookat = matrix_build_lookat(cx, cy, cz, cx + dcos(cdir), cy - dsin(cdir), cz + dtan(cpitch), 0, 0, 1);
camera_set_view_mat(camera, mLookat);
camera_apply(camera);

vertex_submit(buffer, pr_trianglelist, sprite_get_texture(ground_spr, 0));