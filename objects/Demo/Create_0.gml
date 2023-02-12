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
SetPhysicsWorldIterationsSolver(world, 15, 7);

ground_texture = sprite_get_texture(ground_spr, 0);
ground_model = model_build_cube(-50, -50, -1, 50, 50, 1);
ground_shape = CreateBoxShape(50, 50, 1);
ground_body = CreateRigidbody(world, 0, 0, 0, 0, 0, 0);
SetRigidbodyType(ground_body, BodyType.STATIC);
ground_collider = AddCollider(ground_body, ground_shape, 0, 0, 0, 0, 0, 0);

SetColliderBounciness(ground_collider, 0.0);
SetColliderFrictionCoefficient(ground_collider, 1.0);

// Characteristics
car_length = 4.0;
car_width = 1.8;
car_height = 1.0;
car_weight = 100.0;

wheel_radius = 0.3;
wheel_width = 0.3;
wheel_weight = 1.0;
wheel_offset_weight = 15.0;

car_texture = sprite_get_texture(box_spr, 0)
car_model = model_build_cube(-car_length / 2, -car_width / 2, -car_height / 2, car_length / 2, car_width / 2, car_height / 2);
car_shape = CreateBoxShape(car_length / 2, car_width / 2, car_height / 2);
car_body = CreateRigidbody(world, 0, 0, 2, 0, 0, 0);
// car_collider = AddCollider(car_body, car_shape, 0, 0, 0, 0, 0, 0);
SetRigidbodyMass(car_body, car_weight);

wheel_model = model_build_cube(-wheel_radius, -wheel_width / 2, -wheel_radius, wheel_radius, wheel_width / 2, wheel_radius);
wheel_shape = CreateSphereShape(wheel_radius); //, wheel_width);

wheel_front_left_offset_body = CreateRigidbody(world, car_length / 2, -car_width / 2, 1 + wheel_radius);
wheel_front_right_offset_body = CreateRigidbody(world, car_length / 2, car_width / 2, 1 + wheel_radius);
wheel_back_left_offset_body = CreateRigidbody(world, -car_length / 2, -car_width / 2, 1 + wheel_radius);
wheel_back_right_offset_body = CreateRigidbody(world, -car_length / 2, car_width / 2, 1 + wheel_radius);

SetRigidbodyMass(wheel_front_left_offset_body, wheel_offset_weight);
SetRigidbodyMass(wheel_front_right_offset_body, wheel_offset_weight);
SetRigidbodyMass(wheel_back_left_offset_body, wheel_offset_weight);
SetRigidbodyMass(wheel_back_right_offset_body, wheel_offset_weight);

// Not sure why it's more stable if their anchor is the center of car_body
CreateFixedJoint(world, car_body, wheel_front_left_offset_body, 0, 0, 2);
CreateFixedJoint(world, car_body, wheel_front_right_offset_body, 0, 0, 2);
CreateFixedJoint(world, car_body, wheel_back_left_offset_body, 0, 0, 2);
CreateFixedJoint(world, car_body, wheel_back_right_offset_body, 0, 0, 2);

// Steering
wheel_front_left_steer_body = CreateRigidbody(world, car_length / 2, -car_width / 2, 1 + wheel_radius);
wheel_front_right_steer_body = CreateRigidbody(world, car_length / 2, car_width / 2, 1 + wheel_radius);

CreateHingeJoint(world, wheel_front_left_offset_body, wheel_front_left_steer_body, car_length / 2, -car_width / 2, 1 + wheel_radius, 0, 0, 1);
CreateHingeJoint(world, wheel_front_right_offset_body, wheel_front_right_steer_body, car_length / 2, car_width / 2, 1 + wheel_radius, 0, 0, 1);

wheel_front_left_wheel_body = CreateRigidbody(world, car_length / 2, -car_width / 2, 1 + wheel_radius);
wheel_front_right_wheel_body = CreateRigidbody(world, car_length / 2, car_width / 2, 1 + wheel_radius);
wheel_back_left_wheel_body = CreateRigidbody(world, -car_length / 2, -car_width / 2, 1 + wheel_radius);
wheel_back_right_wheel_body = CreateRigidbody(world, -car_length / 2, car_width / 2, 1 + wheel_radius);

SetRigidbodyMass(wheel_front_left_wheel_body, wheel_weight);
SetRigidbodyMass(wheel_front_right_wheel_body, wheel_weight);
SetRigidbodyMass(wheel_back_left_wheel_body, wheel_weight);
SetRigidbodyMass(wheel_back_right_wheel_body, wheel_weight);

wheel_front_left_wheel_collider = AddCollider(wheel_front_left_wheel_body, wheel_shape, 0, 0, 0, degtorad(90), 0, 0);
wheel_front_right_wheel_collider = AddCollider(wheel_front_right_wheel_body, wheel_shape, 0, 0, 0, degtorad(90), 0, 0);
wheel_back_left_wheel_collider = AddCollider(wheel_back_left_wheel_body, wheel_shape, 0, 0, 0, degtorad(90), 0, 0);
wheel_back_right_wheel_collider = AddCollider(wheel_back_right_wheel_body, wheel_shape, 0, 0, 0, degtorad(90), 0, 0);

SetColliderBounciness(wheel_front_left_wheel_collider, 0.0);
SetColliderBounciness(wheel_front_right_wheel_collider, 0.0);
SetColliderBounciness(wheel_back_left_wheel_collider, 0.0);
SetColliderBounciness(wheel_back_right_wheel_collider, 0.0);

SetColliderFrictionCoefficient(wheel_front_left_wheel_collider, 0.5);
SetColliderFrictionCoefficient(wheel_front_right_wheel_collider, 0.5);
SetColliderFrictionCoefficient(wheel_back_left_wheel_collider, 1.0);
SetColliderFrictionCoefficient(wheel_back_right_wheel_collider, 1.0);

CreateFixedJoint(world, wheel_back_left_wheel_body, wheel_back_right_wheel_body, -car_length / 2, 0, 1 + wheel_radius, 0, -1, 0);

CreateHingeJoint(world, wheel_front_left_steer_body, wheel_front_left_wheel_body, car_length / 2, -car_width / 2, 1 +  wheel_radius, 0, 1, 0);
CreateHingeJoint(world, wheel_front_right_steer_body, wheel_front_right_wheel_body, car_length / 2, car_width / 2, 1 + wheel_radius, 0, 1, 0);
wheel_back_left_wheel_joint = CreateHingeJoint(world, wheel_back_left_offset_body, wheel_back_left_wheel_body, -car_length / 2, -car_width / 2, 1 + wheel_radius, 0, 1, 0);
wheel_back_right_wheel_joint = CreateHingeJoint(world, wheel_back_right_offset_body, wheel_back_right_wheel_body, -car_length / 2, car_width / 2, 1 + wheel_radius, 0, 1, 0);

started = false;