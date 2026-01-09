extends CameraSystem

var offset = Vector3.ZERO:
	set(new_val):
		offset = new_val
		position_offset = offset
