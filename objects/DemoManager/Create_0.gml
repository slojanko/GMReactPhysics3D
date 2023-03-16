// Physics setup
global.shared_buffer = buffer_create(65536, buffer_fixed, 1);
global.shared_array = array_create(65536, 0)
Init(buffer_get_address(global.shared_buffer), ptr(global.shared_array));

demos = [DemoSimulationThread];
currentDemo = 0;