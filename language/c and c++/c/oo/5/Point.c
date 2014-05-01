#include "Point.r"

void move(void* point, int dx, int dy) {
	struct Point* self = point;
	self->x += dx;
	self->y += dy;
}

void draw(const void* _self) {
	const struct PointClass* self = _self;
	self->draw(self);
}

static void * Point_ctor (void * _self, va_list * app)
{
	struct Point * self = super_ctor(Point, _self, app);
	self -> x = va_arg(* app, int);
	self -> y = va_arg(* app, int);
	return self;
}

static void * PointClass_ctor (void * _self, va_list * app)
{
	struct PointClass * self
		= super_ctor(PointClass, _self, app);
	typedef void (* voidf) ();
	voidf selector;
	va_list ap = * app;
	while ((selector = va_arg(ap, voidf)))
	{
		voidf method = va_arg(ap, voidf);
		if (selector == (voidf) draw)
			* (voidf *) & self -> draw = method;
	}
	return self;
}

static void Point_draw (const void * _self)
{
	const struct Point * self = _self;
	printf("\".\" at %d,%d\n", self -> x, self -> y);
}

void initPoint (void)
{
	if (! PointClass)
		PointClass = new(Class, "PointClass",
				Class, sizeof(struct PointClass),
				ctor, PointClass_ctor,
				0);
	if (! Point)
		Point = new(PointClass, "Point",
				Object, sizeof(struct Point),
				ctor, Point_ctor,
				draw, Point_draw,
				0);
}
