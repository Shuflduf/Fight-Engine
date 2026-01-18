class_name CameraSystem
extends Node

var position_offset: Vector3
var rotation_offset: Vector3

@onready var manager: CameraSystemManager = get_parent()
@onready var cam: Camera3D = manager.cam
