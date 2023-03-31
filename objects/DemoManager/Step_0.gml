if (keyboard_check_pressed(vk_escape)) {
	game_end();
}

if (queued_demo == current_demo) {
	if (keyboard_check_pressed(vk_left)) {
		 demos[current_demo].destroy();
		 queued_demo = (queued_demo - 1 + array_length(demos)) % array_length(demos);
	}

	if (keyboard_check_pressed(vk_right)) {
		 demos[current_demo].destroy();
		 queued_demo = (queued_demo + 1) % array_length(demos);
	}
}