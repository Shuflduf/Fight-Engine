extends Node3D

const SPINE_INDEX = 1
@export var hand_handles: Array[Marker3D]

@onready var skeleton: Skeleton3D = $metarig/Skeleton3D
@onready var og_hand_transforms: Array = hand_handles.map(func(hand): return hand.transform)

#@onready var right_hand: Marker3D = $metarig/Skeleton3D/spine_004/RightHand
#@onready var right_hand_og_trans = right_hand.transform

func set_spine_angle(new_angle: float):
	skeleton.set_bone_pose_rotation(SPINE_INDEX, Quaternion.from_euler(Vector3(new_angle, 0.0, 0.0)))

func shoot(index: int):
	var target_hand = hand_handles[index]
	var og_trans = og_hand_transforms[index]
	var tween = get_tree().create_tween().set_ease(Tween.EASE_OUT)
	tween.tween_property(target_hand, ^"position:z", og_trans.origin.z - 0.1, 0.05).set_trans(Tween.TRANS_EXPO)
	tween.tween_property(target_hand, ^"position:z", og_trans.origin.z, 0.6).set_trans(Tween.TRANS_CUBIC)
