if (mouse_check_button_pressed(mb_left)) {
	started = true;	
}

if (started) {
	UpdatePhysicsWorld(world, delta_time / 1000000);
}

if (keyboard_check_pressed(vk_up)) {
	SetHingeJointMotorSpeedTorque(wheel_back_left_wheel_joint, -1.0, 100.0);
	SetHingeJointMotorSpeedTorque(wheel_back_right_wheel_joint, -1.0, 100.0);
	
	HingeJointEnableMotor(wheel_back_left_wheel_joint, true);
	HingeJointEnableMotor(wheel_back_right_wheel_joint, true);
}

if (keyboard_check_pressed(vk_down)) {
	SetHingeJointMotorSpeedTorque(wheel_back_left_wheel_joint, 1.0, -100.0);
	SetHingeJointMotorSpeedTorque(wheel_back_right_wheel_joint, 1.0, -100.0);
	
	HingeJointEnableMotor(wheel_back_left_wheel_joint, true);
	HingeJointEnableMotor(wheel_back_right_wheel_joint, true);
}

if (!keyboard_check(vk_up) && !keyboard_check(vk_down)) {
	HingeJointEnableMotor(wheel_back_left_wheel_joint, false);
	HingeJointEnableMotor(wheel_back_right_wheel_joint, false);
}

if (keyboard_check(vk_left)) {
	SetHingeJointMinMaxAngleLimit(wheel_front_left_steer_joint, degtorad(-35.0), 0.0);
	SetHingeJointMinMaxAngleLimit(wheel_front_right_steer_joint, degtorad(-35.0), 0.0);
	
	SetHingeJointMotorSpeedTorque(wheel_front_left_steer_joint, -1.0, -5000.0);
	SetHingeJointMotorSpeedTorque(wheel_front_right_steer_joint, -1.0, -5000.0);
	
	HingeJointEnableMotor(wheel_front_left_steer_joint, true);
	HingeJointEnableMotor(wheel_front_right_steer_joint, true);
}

if (keyboard_check(vk_right)) {
	SetHingeJointMinMaxAngleLimit(wheel_front_left_steer_joint, 0.0, degtorad(35.0));
	SetHingeJointMinMaxAngleLimit(wheel_front_right_steer_joint, 0.0, degtorad(35.0));
	
	SetHingeJointMotorSpeedTorque(wheel_front_left_steer_joint, -1.0, 5000.0);
	SetHingeJointMotorSpeedTorque(wheel_front_right_steer_joint, -1.0, 5000.0);
	
	HingeJointEnableMotor(wheel_front_left_steer_joint, true);
	HingeJointEnableMotor(wheel_front_right_steer_joint, true);
}

if (!keyboard_check(vk_left) && !keyboard_check(vk_right)) {
	HingeJointEnableMotor(wheel_front_left_steer_joint, false);
	HingeJointEnableMotor(wheel_front_right_steer_joint, false);
}

//if(mouse_check_button_pressed(mb_right)) {
//	var sumDouble = 0;
//	var start = get_timer();
//	for(var i = 0; i < 10000000; i++) {
//		sumDouble += box_array[i % cube_count];
//	}
//	show_debug_message(sumDouble);
//	show_debug_message((get_timer() - start) / 1000000);



//	var sumInt = int64(0);
//	start = get_timer();
//	var limit = int64(10000000);
//	for(var i = int64(0); i < limit; i++) {
//		sumInt += box_array[i % cube_count];
//	}
//	show_debug_message(sumInt);
//	show_debug_message((get_timer() - start) / 1000000);
//}

//xx = window_mouse_get_x();
//mLookat = matrix_build_lookat(xx,yy,zz, xx, 0, 0 ,0, 0, 1);
//camera_set_view_mat(view_camera[0], mLookat);