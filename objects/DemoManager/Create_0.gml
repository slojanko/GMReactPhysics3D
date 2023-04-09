// Physics setup
global.shared_buffer = buffer_create(65536, buffer_fixed, 1);
global.shared_array = array_create(65536, 0)
Init(buffer_get_address(global.shared_buffer), ptr(global.shared_array));

demos = [DemoSimulationThread, DemoRaycast, DemoSlowMotion, DemoConvexShape];
current_demo = -1;
queued_demo = 0; 

function perform_queue() {
	instance_create_layer(0, 0, "Instances", demos[queued_demo]);
	current_demo = queued_demo;
}

perform_queue();