extends Skill

@export var projectile: PackedScene

var current_cooldown = 0.0

@onready var cam: Camera3D = get_parent().cam

func use():
	if current_cooldown > 0.0:
		return
		
	var new_cleaver: Node3D = projectile.instantiate()
	new_cleaver.target_position = cam.global_position + (-cam.global_transform.basis.z * 15.0)
	get_tree().root.add_child(new_cleaver)
	new_cleaver.global_position = cam.global_position
	
	
	current_cooldown = info.cooldown

func _physics_process(delta: float) -> void:
	current_cooldown -= delta
