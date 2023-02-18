// Physics setup
shared_buffer = buffer_create(65536, buffer_fixed, 1);
shared_array = array_create(65536, 0)
Init(buffer_get_address(shared_buffer), ptr(shared_array));

world = CreatePhysicsWorld();
SetPhysicsWorldGravity(world, 0.0, 0.0, -9.81);
SetPhysicsWorldIterationsVelocitySolver(world, 5);
SetPhysicsWorldIterationsPositionSolver(world, 3);

ground_texture = sprite_get_texture(ground_spr, 0);
ground_model = import_obj("ground.obj");
ground_shape = CreateBoxShape(150, 150, 1);
ground_body = CreateRigidbody(world, 0, 0, 0, 0, 0, 0);
SetRigidbodyType(ground_body, BodyType.STATIC);
ground_collider = AddCollider(ground_body, ground_shape, 0, 0, 0, 0, 0, 0);

SetColliderBounciness(ground_collider, 0.0);
SetColliderFrictionCoefficient(ground_collider, 1.0);

// Characteristics
car_length = 4.0;
car_width = 1.8;
car_height = 1.0;
car_weight = 50.0;
car_z = 2.0;

car_length_half = car_length / 2.0;
car_width_half = car_width / 2.0;
car_height_half = car_height / 2.0;

wheel_radius = 0.3;
wheel_width = 0.3;
wheel_weight = 10.0;
wheel_offset_weight = 50.0;
wheel_z = 1.5;

car_texture = sprite_get_texture(box_spr, 0)
car_model = model_build_cube(-car_length_half, -car_width_half, -car_height_half, car_length_half, car_width_half, car_height_half);
car_shape = CreateBoxShape(car_length_half, car_width_half, car_height_half);
car_body = CreateRigidbody(world, 0, 0, car_z, 0, 0, 0);
SetRigidbodyMass(car_body, car_weight);

wheel_model = model_build_cube(-wheel_radius, -wheel_width / 2, -wheel_radius, wheel_radius, wheel_width / 2, wheel_radius);
wheel_shape = CreateSphereShape(wheel_radius); //, wheel_width);

wheel_front_left_offset_body = CreateRigidbody(world, car_length_half, -car_width_half, wheel_z);
wheel_front_right_offset_body = CreateRigidbody(world, car_length_half, car_width_half, wheel_z);
wheel_back_left_offset_body = CreateRigidbody(world, -car_length_half, -car_width_half, wheel_z);
wheel_back_right_offset_body = CreateRigidbody(world, -car_length_half, car_width_half, wheel_z);

SetRigidbodyMass(wheel_front_left_offset_body, wheel_offset_weight);
SetRigidbodyMass(wheel_front_right_offset_body, wheel_offset_weight);
SetRigidbodyMass(wheel_back_left_offset_body, wheel_offset_weight);
SetRigidbodyMass(wheel_back_right_offset_body, wheel_offset_weight);

// Not sure why it's more stable if their anchor is the center of car_body
CreateFixedJoint(world, car_body, wheel_front_left_offset_body, 0, 0, car_z);
CreateFixedJoint(world, car_body, wheel_front_right_offset_body, 0, 0, car_z);
CreateFixedJoint(world, car_body, wheel_back_left_offset_body, 0, 0, car_z);
CreateFixedJoint(world, car_body, wheel_back_right_offset_body, 0, 0, car_z);

// Steering
wheel_front_left_steer_body = CreateRigidbody(world, car_length_half, -car_width_half, wheel_z);
wheel_front_right_steer_body = CreateRigidbody(world, car_length_half, car_width_half, wheel_z);

wheel_front_left_steer_joint = CreateHingeJoint(world, wheel_front_left_offset_body, wheel_front_left_steer_body, car_length_half, -car_width_half, wheel_z, 0, 0, 1);
wheel_front_right_steer_joint = CreateHingeJoint(world, wheel_front_right_offset_body, wheel_front_right_steer_body, car_length_half, car_width_half, wheel_z, 0, 0, 1);

HingeJointEnableLimit(wheel_front_left_steer_joint, true);
HingeJointEnableLimit(wheel_front_right_steer_joint, true);

wheel_front_left_wheel_body = CreateRigidbody(world, car_length_half, -car_width_half, wheel_z);
wheel_front_right_wheel_body = CreateRigidbody(world, car_length_half, car_width_half, wheel_z);
wheel_back_left_wheel_body = CreateRigidbody(world, -car_length_half, -car_width_half, wheel_z);
wheel_back_right_wheel_body = CreateRigidbody(world, -car_length_half, car_width_half, wheel_z);

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

SetColliderFrictionCoefficient(wheel_front_left_wheel_collider, 0.35);
SetColliderFrictionCoefficient(wheel_front_right_wheel_collider, 0.35);
SetColliderFrictionCoefficient(wheel_back_left_wheel_collider, 0.75);
SetColliderFrictionCoefficient(wheel_back_right_wheel_collider, 0.75);

CreateFixedJoint(world, wheel_back_left_wheel_body, wheel_back_right_wheel_body, -car_length_half, 0, wheel_z, 0, 1, 0);

CreateHingeJoint(world, wheel_front_left_steer_body, wheel_front_left_wheel_body, car_length_half, -car_width_half, wheel_z, 0, 1, 0);
CreateHingeJoint(world, wheel_front_right_steer_body, wheel_front_right_wheel_body, car_length_half, car_width_half, wheel_z, 0, 1, 0);
wheel_back_left_wheel_joint = CreateHingeJoint(world, wheel_back_left_offset_body, wheel_back_left_wheel_body, -car_length_half, -car_width_half, wheel_z, 0, 1, 0);
wheel_back_right_wheel_joint = CreateHingeJoint(world, wheel_back_right_offset_body, wheel_back_right_wheel_body, -car_length_half, car_width_half, wheel_z, 0, 1, 0);

started = false;