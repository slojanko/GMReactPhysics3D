if (mouse_check_button(mb_left)) {
	UpdatePhysicsWorld(world, delta_time / 1000000);
}

//xx = window_mouse_get_x();
//mLookat = matrix_build_lookat(xx,yy,zz, xx, 0, 0 ,0, 0, 1);
//camera_set_view_mat(view_camera[0], mLookat);