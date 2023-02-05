if (mouse_check_button_pressed(mb_left)) {
	var a = 5;
	var b = 6;
	var c = 0;
	
	a = { a : 5, b : 6 };

	var timer = get_timer();
	Change(a);
	show_debug_message(a);
	//repeat(1000000) {
	//	c += MultiplyNew(a);
	//}
	//show_debug_message("Time: {0} {1}", (get_timer() - timer) / 1000, c);
	//show_debug_message("{0} {1}", a, c);

	//c = 0;
	//timer = get_timer();
	//repeat(1000000) {
	//	c += MultiplyOld(a, b);
	//}
	//show_debug_message("Time: {0} {1}", (get_timer() - timer) / 1000, c);
}