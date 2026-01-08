extends Node3D

@onready var stair_cast: ShapeCast3D = $StairCast
@onready var stair_checker: RayCast3D = $StairChecker
@onready var player: CharacterBody3D = get_parent()

var last_player_vel = Vector3.ZERO

func _physics_process(_delta: float) -> void:
	if stair_cast.is_colliding():
		
		var flat_player_vel = Vector3(player.velocity.x, 0.0, player.velocity.z)
		if !flat_player_vel.is_zero_approx():
			last_player_vel = flat_player_vel

		var local_col_point = self.to_local(stair_cast.get_collision_point(0))
		stair_checker.position.x = local_col_point.x * 1.2
		stair_checker.position.z = local_col_point.z * 1.2
		stair_checker.force_raycast_update()
		var d = stair_checker.position.normalized().dot(last_player_vel.normalized())
		print(d)
		if stair_checker.is_colliding() && (flat_player_vel.length() > 2.0 or !player.wish_dir.is_zero_approx()):
			player.position.y += self.to_local(stair_checker.get_collision_point()).y + 1.01
			#player.velocity = before_stair_velocity
			#player.position += player.wish_dir * 0.2
			#player.velocity = velocity_buffer + (Vector3.UP * 0.5)
			#player.position += last_wish_dir * 0.2
			#player.position.x += player.velocity.x * delta * 10.0
			#player.position.z += player.velocity.z * delta * 10.0
			
