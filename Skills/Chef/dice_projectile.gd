extends Node3D

var target_position: Vector3

func _ready() -> void:
	var tween = get_tree().create_tween()
	tween.tween_property(self, ^"global_position", target_position, 1.0)

func _physics_process(delta: float) -> void:
	rotation.y += delta * 30.0
