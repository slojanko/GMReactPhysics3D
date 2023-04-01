draw_set_halign(fa_right);
draw_text(window_get_width(), 0, string("Physics took: {0}s", string_format(last_update_took / 1000000, 1, 3)));
draw_set_halign(fa_left);