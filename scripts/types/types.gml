enum BodyType {
	staticc = 0,
	kinematic = 1,
	dynamic = 2,
}

function model_build_cube(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7) {
	var x1 = argument0,
	    y1 = argument1,
	    z1 = argument2,
	    x2 = argument3,
	    y2 = argument4,
	    z2 = argument5,
	    hr = argument6,
	    vr = argument7,
	    vb = vertex_create_buffer();

	/* Prepare VBO */
	vertex_begin(vb, format);

	/* Top */
	vertex_default(vb, x1, y1, z2, 0, 0, 1, 0, 0, c_white, 1);
	vertex_default(vb, x2, y1, z2, 0, 0, 1, hr, 0, c_white, 1);
	vertex_default(vb, x1, y2, z2, 0, 0, 1, 0, vr, c_white, 1);

	vertex_default(vb, x2, y1, z2, 0, 0, 1, hr, 0, c_white, 1);
	vertex_default(vb, x2, y2, z2, 0, 0, 1, hr, vr, c_white, 1);
	vertex_default(vb, x1, y2, z2, 0, 0, 1, 0, vr, c_white, 1);

	/* Bottom */
	vertex_default(vb, x1, y2, z1, 0, 0, -1, 0, vr, c_white, 1);
	vertex_default(vb, x2, y1, z1, 0, 0, -1, hr, 0, c_white, 1);
	vertex_default(vb, x1, y1, z1, 0, 0, -1, 0, 0, c_white, 1);

	vertex_default(vb, x1, y2, z1, 0, 0, -1, 0, vr, c_white, 1);
	vertex_default(vb, x2, y2, z1, 0, 0, -1, hr, vr, c_white, 1);
	vertex_default(vb, x2, y1, z1, 0, 0, -1, hr, 0, c_white, 1);

	/* Front */
	vertex_default(vb, x1, y2, z2, 0, 1, 0, 0, vr, c_white, 1);
	vertex_default(vb, x2, y2, z1, 0, 1, 0, hr, 0, c_white, 1);
	vertex_default(vb, x1, y2, z1, 0, 1, 0, 0, 0, c_white, 1);

	vertex_default(vb, x1, y2, z2, 0, 1, 0, 0, vr, c_white, 1);
	vertex_default(vb, x2, y2, z2, 0, 1, 0, hr, vr, c_white, 1);
	vertex_default(vb, x2, y2, z1, 0, 1, 0, hr, 0, c_white, 1);

	/* Back */
	vertex_default(vb, x1, y1, z1, 0, -1, 0, 0, 0, c_white, 1);
	vertex_default(vb, x2, y1, z1, 0, -1, 0, hr, 0, c_white, 1);
	vertex_default(vb, x1, y1, z2, 0, -1, 0, 0, vr, c_white, 1);

	vertex_default(vb, x2, y1, z1, 0, -1, 0, hr, 0, c_white, 1);
	vertex_default(vb, x2, y1, z2, 0, -1, 0, hr, vr, c_white, 1);
	vertex_default(vb, x1, y1, z2, 0, -1, 0, 0, vr, c_white, 1);

	/* Right */
	vertex_default(vb, x2, y1, z1, 1, 0, 0, 0, 0, c_white, 1);
	vertex_default(vb, x2, y2, z1, 1, 0, 0, hr, 0, c_white, 1);
	vertex_default(vb, x2, y1, z2, 1, 0, 0, 0, vr, c_white, 1);

	vertex_default(vb, x2, y2, z1, 1, 0, 0, hr, 0, c_white, 1);
	vertex_default(vb, x2, y2, z2, 1, 0, 0, hr, vr, c_white, 1);
	vertex_default(vb, x2, y1, z2, 1, 0, 0, 0, vr, c_white, 1);

	/* Left */
	vertex_default(vb, x1, y1, z2, -1, 0, 0, 0, vr, c_white, 1);
	vertex_default(vb, x1, y2, z1, -1, 0, 0, hr, 0, c_white, 1);
	vertex_default(vb, x1, y1, z1, -1, 0, 0, 0, 0, c_white, 1);

	vertex_default(vb, x1, y1, z2, -1, 0, 0, 0, vr, c_white, 1);
	vertex_default(vb, x1, y2, z2, -1, 0, 0, hr, vr, c_white, 1);
	vertex_default(vb, x1, y2, z1, -1, 0, 0, hr, 0, c_white, 1);

	/* Finalize VBO */
	vertex_end(vb);
	vertex_freeze(vb);

	return vb;
}

function vertex_default(argument0, argument1, argument2, argument3, argument4, argument5, argument6, argument7, argument8, argument9, argument10) {
	gml_pragma("forceinline");

	vertex_position_3d(argument0, argument1, argument2, argument3);
	vertex_texcoord(argument0, argument7, argument8);
	vertex_colour(argument0, argument9, argument10);
}