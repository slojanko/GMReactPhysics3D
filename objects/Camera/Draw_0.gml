var mLookat = matrix_build_lookat(cx, cy, cz, cx + dcos(cdir), cy - dsin(cdir), cz + dtan(cpitch), 0, 0, 1);
camera_set_view_mat(camera, mLookat);
camera_apply(camera);