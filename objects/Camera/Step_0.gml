if (!window_has_focus()) {
	return; 
}

cdir -= (window_mouse_get_x() - window_get_width() / 2) / 10;
cpitch -= (window_mouse_get_y() - window_get_height() / 2) / 10;
cpitch = clamp(cpitch, -85, 85);

window_mouse_set(window_get_width() / 2, window_get_height() / 2);

if (keyboard_check(ord("A"))) {
    cx -= dsin(cdir) * move_speed;
    cy -= dcos(cdir) * move_speed;
}

if (keyboard_check(ord("D"))) {
    cx += dsin(cdir) * move_speed;
    cy += dcos(cdir) * move_speed;
}

if (keyboard_check(ord("W"))) {
    cx += dcos(cdir) * move_speed;
    cy -= dsin(cdir) * move_speed;
}

if (keyboard_check(ord("S"))) {
    cx -= dcos(cdir) * move_speed;
    cy += dsin(cdir) * move_speed;
}

if (keyboard_check(ord("Q"))) {
	cz -= move_speed;
}

if (keyboard_check(ord("E"))) {
	cz += move_speed;
}