if (!window_has_focus() || skip_once) {
	skip_once = false;
	return; 
}

cdir -= base_mouse * (window_mouse_get_x() - window_get_width() / 2) * delta_time_seconds;
cpitch -= base_mouse * (window_mouse_get_y() - window_get_height() / 2) * delta_time_seconds;
cpitch = clamp(cpitch, -85, 85);
window_mouse_set(window_get_width() / 2, window_get_height() / 2);

var move_speed = base_speed * (1 + 2 * keyboard_check(vk_shift)) * delta_time_seconds;

if (keyboard_check(ord("A"))) {
    cx -= dsin(cdir) * move_speed;
    cy -= dcos(cdir) * move_speed;
}

if (keyboard_check(ord("D"))) {
    cx += dsin(cdir) * move_speed;
    cy += dcos(cdir) * move_speed;
}

if (keyboard_check(ord("W"))) {
    cx += dcos(cdir) * dcos(cpitch) * move_speed;
    cy -= dsin(cdir) * dcos(cpitch) * move_speed;
	cz += dsin(cpitch) * move_speed;
}

if (keyboard_check(ord("S"))) {
    cx -= dcos(cdir) * dcos(cpitch) * move_speed;
    cy += dsin(cdir) * dcos(cpitch) * move_speed;
	cz -= dsin(cpitch) * move_speed;
}

if (keyboard_check(ord("Q"))) {
	cz -= move_speed;
}

if (keyboard_check(ord("E"))) {
	cz += move_speed;
}