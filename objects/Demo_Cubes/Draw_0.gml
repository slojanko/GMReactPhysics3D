shader_set(surface_shd);
matrix_set(matrix_world, matrix_build(0, 0, 0, 0, 0, 0, 1, 1, 1));
vertex_submit(ground_model, pr_trianglelist, ground_texture);

matrix_set(matrix_world, GetTransformMatrix(car_body));
vertex_submit(car_model, pr_trianglelist, car_texture);

matrix_set(matrix_world, GetTransformMatrix(wheel_front_left_wheel_body));
vertex_submit(wheel_model, pr_trianglelist, car_texture);

matrix_set(matrix_world, GetTransformMatrix(wheel_front_right_wheel_body));
vertex_submit(wheel_model, pr_trianglelist, car_texture);

matrix_set(matrix_world, GetTransformMatrix(wheel_back_left_wheel_body));
vertex_submit(wheel_model, pr_trianglelist, car_texture);

matrix_set(matrix_world, GetTransformMatrix(wheel_back_right_wheel_body));
vertex_submit(wheel_model, pr_trianglelist, car_texture);

matrix_set(matrix_world, matrix_build_identity());
shader_reset();