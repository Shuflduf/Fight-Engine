extends Node3D

@onready var stair_cast: ShapeCast3D = $StairCast
@onready var stair_checker: RayCast3D = $StairChecker

@onready var player: CharacterBody3D = get_parent()

var before_stair_velocity = Vector3.ZERO

func _physics_process(delta: float) -> void:
	if stair_cast.is_colliding():
		if !player.velocity.is_zero_approx():
			before_stair_velocity = player.velocity
		var local_col_point = self.to_local(stair_cast.get_collision_point(0))
		stair_checker.position.x = local_col_point.x * 1.1
		stair_checker.position.z = local_col_point.z * 1.1
		stair_checker.force_raycast_update()
		if stair_checker.is_colliding():
			player.position.y += local_col_point.y + 1.05
			player.velocity = before_stair_velocity
			#player.position.x += player.velocity.x * delta * 10.0
			#player.position.z += player.velocity.z * delta * 10.0
			print("STAIR")
