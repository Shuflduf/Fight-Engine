extends Node3D

const SPINE_INDEX = 1

@onready var skeleton: Skeleton3D = $metarig/Skeleton3D



func set_spine_angle(new_angle: float):
	skeleton.set_bone_pose_rotation(SPINE_INDEX, Quaternion.from_euler(Vector3(new_angle, 0.0, 0.0)))
