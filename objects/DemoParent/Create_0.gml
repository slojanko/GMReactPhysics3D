depth_surface = -1;

last_update_start = 0.0;
last_update_took = 0.0;

queued_destroy = false;

function destroy() {
	queued_destroy = true;
}