gpu_set_zwriteenable(true);
gpu_set_ztestenable(true);
// show_debug_overlay(true);

view_enabled = true;
view_set_visible(0, true);

cx = 0;
cy = 96;
cz = 25;
cdir = 0;
cpitch = 0;

camera = camera_create();
projMat = matrix_build_projection_perspective_fov(-60, -view_get_wport(0)/view_get_hport(0), 1, 1000);
camera_set_proj_mat(camera, projMat);
view_set_camera(0, camera);

// Physics setup
shared_buffer = buffer_create(65536, buffer_fixed, 1);
//shared_array = array_create(65536)
Init(buffer_get_address(shared_buffer));

world = CreatePhysicsWorld();
SetPhysicsWorldGravity(world, 0.0, 0.0, -9.81);
SetPhysicsWorldIterationsSolver(world, 10, 5);

ground_texture = sprite_get_texture(ground_spr, 0);
ground_model = model_build_cube(-200, -200, -1, 200, 200, 1);
ground_shape = CreateBoxShape(200, 200, 1);
ground_body = CreateRigidbody(world, 0, 0, 0, 0, 0 * 0.0174533, 0);
SetRigidbodyType(ground_body, BodyType.STATIC);
ground_collider = AddCollider(ground_body, ground_shape, 0, 0, 0, 0, 0, 0);
SetColliderFrictionCoefficient(ground_collider, 1.0);

car_texture = sprite_get_texture(box_spr, 0)
car_model = model_build_cube(-16, -8, -2, 16, 8, 2);
car_shape = CreateBoxShape(16, 8, 2);
car_body = CreateRigidbody(world, 0, 0, 16, 0, 0, 0);
// car_collider = AddCollider(car_body, car_shape, 0, 0, 0, 0, 0, 0);
SetRigidbodyMass(car_body, 10.0);

wheel_model = model_build_cube(-2, -1, -2, 2, 1, 2);
wheel_shape = CreateCapsuleShape(2, 0.15);

wheel_front_left_offset_body = CreateRigidbody(world, 16, -8, 10);
wheel_front_right_offset_body = CreateRigidbody(world, 16, 8, 10);
wheel_back_left_offset_body = CreateRigidbody(world, -16, -8, 10);
wheel_back_right_offset_body = CreateRigidbody(world, -16, 8, 10);

// Not sure why it's more stable if their anchor is the center of car_body
CreateFixedJoint(world, car_body, wheel_front_left_offset_body, 0, 0, 16);
CreateFixedJoint(world, car_body, wheel_front_right_offset_body, 0, 0, 16);
CreateFixedJoint(world, car_body, wheel_back_left_offset_body, 0, 0, 16);
CreateFixedJoint(world, car_body, wheel_back_right_offset_body, 0, 0, 16);

// Steering
wheel_front_left_steer_body = CreateRigidbody(world, 16, -8, 10);
wheel_front_right_steer_body = CreateRigidbody(world, 16, 8, 10);

wheel_front_left_steer_joint = CreateHingeJoint(world, wheel_front_left_offset_body, wheel_front_left_steer_body, 16, -8, 10, 0, 0, 1);
wheel_front_right_steer_joint = CreateHingeJoint(world, wheel_front_right_offset_body, wheel_front_right_steer_body, 16, 8, 10, 0, 0, 1);

HingeJointEnableLimit(wheel_front_left_steer_joint, true);
HingeJointEnableLimit(wheel_front_right_steer_joint, true);

SetHingeJointMinMaxAngleLimit(wheel_front_left_steer_joint, 0, 0);
SetHingeJointMinMaxAngleLimit(wheel_front_right_steer_joint, 0, 0);

wheel_front_left_wheel_body = CreateRigidbody(world, 16, -8, 10);
wheel_front_right_wheel_body = CreateRigidbody(world, 16, 8, 10);
wheel_back_left_wheel_body = CreateRigidbody(world, -16, -8, 10);
wheel_back_right_wheel_body = CreateRigidbody(world, -16, 8, 10);

SetRigidbodyMass(wheel_front_left_wheel_body, 5);
SetRigidbodyMass(wheel_front_right_wheel_body, 5);
SetRigidbodyMass(wheel_back_left_wheel_body, 5);
SetRigidbodyMass(wheel_back_right_wheel_body, 5);

wheel_front_left_wheel_collider = AddCollider(wheel_front_left_wheel_body, wheel_shape, 0, 0, 0, degtorad(90), 0, 0);
wheel_front_right_wheel_collider = AddCollider(wheel_front_right_wheel_body, wheel_shape, 0, 0, 0, degtorad(90), 0, 0);
wheel_back_left_wheel_collider = AddCollider(wheel_back_left_wheel_body, wheel_shape, 0, 0, 0, degtorad(90), 0, 0);
wheel_back_right_wheel_collider = AddCollider(wheel_back_right_wheel_body, wheel_shape, 0, 0, 0, degtorad(90), 0, 0);

SetColliderFrictionCoefficient(wheel_front_left_wheel_collider, 5.0);
SetColliderFrictionCoefficient(wheel_front_right_wheel_collider, 5.0);
SetColliderFrictionCoefficient(wheel_back_left_wheel_collider, 50.0);
SetColliderFrictionCoefficient(wheel_back_right_wheel_collider, 50.0);

CreateHingeJoint(world, wheel_front_left_steer_body, wheel_front_left_wheel_body, 16, -8, 10, 0, -1, 0);
CreateHingeJoint(world, wheel_front_right_steer_body, wheel_front_right_wheel_body, 16, 8, 10, 0, -1, 0);
wheel_back_left_wheel_joint = CreateHingeJoint(world, wheel_back_left_offset_body, wheel_back_left_wheel_body, -16, -8, 10, 0, -1, 0);
wheel_back_right_wheel_joint = CreateHingeJoint(world, wheel_back_right_offset_body, wheel_back_right_wheel_body, -16, 8, 10, 0, -1, 0);

SetHingeJointMotorSpeedTorque(wheel_back_left_wheel_joint, 2 * pi, 250);
SetHingeJointMotorSpeedTorque(wheel_back_right_wheel_joint, 2 * pi, 250);

started = false;