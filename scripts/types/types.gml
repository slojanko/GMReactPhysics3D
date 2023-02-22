enum BodyType {
	STATIC = 0, 
	KINEMATIC = 1, 
	DYNAMIC = 2,
}

enum HeightDataType {
	HEIGHT_FLOAT_TYPE = 0,
	HEIGHT_DOUBLE_TYPE = 1,
	HEIGHT_INT_TYPE = 2,
}

// NOT IMPLEMENTED YET
//enum TriangleRaycastSide {
//	FRONT = 0,
//	BACK = 1,
//	FRONT_AND_BACK = 2,
//}

enum Category {
	CATEGORY1 = 0x0001,
	CATEGORY2 = 0x0002,
	CATEGORY3 = 0x0004,
	CATEGORY4 = 0x0008,
	CATEGORY5 = 0x0010,
	CATEGORY6 = 0x0020,
	CATEGORY7 = 0x0040,
	CATEGORY8 = 0x0080,
	CATEGORY9 = 0x0100,
	CATEGORY10 = 0x0200,
	CATEGORY11 = 0x0400,
	CATEGORY12 = 0x0800,
	CATEGORY13 = 0x1000,
	CATEGORY14 = 0x2000,
	CATEGORY15 = 0x4000,
	CATEGORY16 = 0x8000,
}

vertex_format_begin();
vertex_format_add_position_3d();
vertex_format_add_texcoord();
vertex_format_add_normal();
// vertex_format_add_color();
global.format = vertex_format_end();
