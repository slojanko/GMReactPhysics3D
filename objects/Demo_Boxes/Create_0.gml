// Physics setup
shared_buffer = buffer_create(65536, buffer_fixed, 1);
shared_array = array_create(65536, 0)
Init(buffer_get_address(shared_buffer), ptr(shared_array));

world = CreatePhysicsWorld();
SetPhysicsWorldGravity(world, 0.0, 0.0, -9.81);
SetPhysicsWorldIterationsVelocitySolver(world, 4);
SetPhysicsWorldIterationsPositionSolver(world, 2);
SetPhysicsWorldEnableSleeping(world, true);
SetPhysicsWorldTimeBeforeSleep(world, 0.5);
SetPhysicsWorldSleepLinearVelocity(world, 0.05);
SetPhysicsWorldSleepLinearVelocity(world, degtorad(5.0));

ground_texture = sprite_get_texture(ground_spr, 0);
ground_model = import_obj("ground.obj");
ground_shape = CreateBoxShape(250, 250, 5);
ground_body = CreateRigidbody(world, 0, 0, 0, 0, 0, 0);
SetRigidbodyType(ground_body, BodyType.STATIC);
AddCollider(ground_body, ground_shape, 0, 0, 0, 0, 0, 0);

box_count = 4096;
box_texture = sprite_get_texture(box_spr, 0);
box_model = model_build_cube(-0.5, -0.5, -0.5, 0.5, 0.5, 0.5);
box_shape = CreateBoxShape(0.5, 0.5, 0.5);
box_array = array_create(box_count);

buffer_seek(shared_buffer, buffer_seek_start, 0);
for(var i = 0; i < box_count; i++) {
	var dist = random_range(10, 60);
	var dir = i * 5;
	var height = 5 + i / 15;
	var box = CreateRigidbody(world, lengthdir_x(dist, dir), lengthdir_y(dist, dir), height, 0, 0, 0);
	var collider = AddCollider(box, box_shape, 0, 0, 0, 0, 0, 0);
	SetColliderBounciness(collider, 0.1);
	box_array[i] = box;
	buffer_write(shared_buffer, buffer_u64, box);
}

simulation = SimulationThread.NONE;
updated_once = false;
last_start = get_timer();
last_update_took = 0.0;

enum SimulationThread {
	NONE,
	RUNNER,
	SEPARATE,
}
SimulationThreadToString = ["None", "Runner", "Separate"];
