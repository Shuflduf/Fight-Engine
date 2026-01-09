extends RigidBody3D


func _on_body_entered(_body: Object) -> void:
	linear_velocity /= 2.0


func _on_explode_timer_timeout() -> void:
	for body in $ExplosionRadius.get_overlapping_bodies():
		print(body)
		var rocket_jump_node = body.get_node(^"RocketJump")
		if rocket_jump_node:
			var vec_to_body = body.global_position - global_position
			var distance = vec_to_body.length()
			var direction_away = vec_to_body.normalized()

			var splash_radius = 120.0
			var damage = 5.0 * (1.0 - distance / splash_radius)

			var knockback = min(damage, 200.0)

			rocket_jump_node.jump(direction_away * knockback)
	for hitbox in $ExplosionRadius.get_overlapping_areas():
		print(hitbox)
		if hitbox.name == &"Hitbox":
			hitbox.hit(10.0)

	queue_free()
