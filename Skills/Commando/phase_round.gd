extends Node

@export var double_tap: Node3D
@export var use_cooldown = 1.0

var current_cooldown = 0.0
var hold_duration = 0.0

func _physics_process(delta: float) -> void:
	current_cooldown -= delta
	if Input.is_action_pressed(&"secondary") and current_cooldown <= 0.0:
		hold_duration += delta
		double_tap.current_cooldown = INF
		for i in double_tap.guns.size():
			var gun: Node3D = double_tap.guns[i]
			var left_side = i % 2 == 0
			var side_mult = 1.0 if left_side else -1.0
			gun.position.x = 0.2 * side_mult
			gun.position.y = i * 0.1
			gun.rotation.x = (-PI * side_mult) / 2.5
	
	if Input.is_action_just_released(&"secondary") and hold_duration > 0.0:
		current_cooldown = use_cooldown
		#await get_tree().create_timer(0.1).timeout
		for i in double_tap.guns.size():
			var gun: Node3D = double_tap.guns[i]
			gun.rotation.z = deg_to_rad(20.0)
		
		await get_tree().create_timer(0.5).timeout
		for i in double_tap.guns.size():
			var gun: Node3D = double_tap.guns[i]
			gun.transform = double_tap.og_gun_transforms[i]
		double_tap.current_cooldown = 0.0
			#gun.rotate_object_local(Vector3.UP, deg_to_rad(10.0))
