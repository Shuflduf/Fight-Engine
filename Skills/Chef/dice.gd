extends Skill

signal revert_abilities
signal used(caught: bool)

@export var projectile: PackedScene
@export var throw_dist = 10.0
@export var cleaver_count = 3

var current_cooldown = 0.0
var active_cleavers: Array[Node3D]
var boosted = false

@onready var player: CharacterBody3D = get_parent().player
@onready var cam: Camera3D = get_parent().cam
@onready var model: Node3D = $Model

#@onready var model_rot = model.rotation.x


func use():
	for cleaver in active_cleavers:
		cleaver.stay()

	if current_cooldown > 0.0:
		return

	if boosted:
		revert_abilities.emit()
		for i in 16:
			add_cleaver(cam.global_position + (get_cleaver_target_dir(i) * throw_dist))
		return

	if active_cleavers.size() < cleaver_count:
		add_cleaver(cam.global_position + (-cam.global_transform.basis.z * throw_dist))

		model.position.z = 0.5
		model.rotation.x = deg_to_rad(50.0)
		var tween = get_tree().create_tween()

		#tween.tween_method(model.rotat)
		tween.tween_property(model, ^"position:z", 0.0, 0.4).set_ease(Tween.EASE_OUT).set_trans(
			Tween.TRANS_BACK
		)
		(
			tween
			. parallel()
			. tween_property(model, ^"rotation:x", 0.0, 0.4)
			. set_ease(Tween.EASE_OUT)
			. set_trans(Tween.TRANS_BACK)
		)

		current_cooldown = info.cooldown


func add_cleaver(target_pos: Vector3):
	var new_cleaver: Node3D = projectile.instantiate()
	new_cleaver.target_position = target_pos
	new_cleaver.player_owner = get_parent().player
	new_cleaver.go_back_target = cam
	new_cleaver.delete.connect(func(): active_cleavers.erase(new_cleaver))
	get_tree().root.add_child(new_cleaver)
	new_cleaver.global_position = cam.global_position
	active_cleavers.append(new_cleaver)


func get_cleaver_target_dir(index: int) -> Vector3:
	const HORIZONTAL_SCALE = cos(PI / 4.0)
	const ANGLE_45 = PI / 4.0

	var angle = ANGLE_45 * index
	var target_dir = Vector3(sin(angle), 0.0, cos(angle))
	if index >= 8:
		target_dir = Vector3(
			target_dir.x * HORIZONTAL_SCALE, sin(ANGLE_45), target_dir.z * HORIZONTAL_SCALE
		)
	return target_dir


func _physics_process(delta: float) -> void:
	current_cooldown -= delta
	self.visible = active_cleavers.size() < cleaver_count
