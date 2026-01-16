extends Skill

signal used

@export var skill_duration = 2.0
@export var jump_height = 8.0

var _cooldown = 0.0
var _active = false
var _current_direction = Vector3.ZERO
var _movement_speed = 0.0
var _elapsed_duration = 0.0
var _used_jump = false

@onready var player: CharacterBody3D = get_parent().player
@onready var cam_systems: CameraSystemManager = get_parent().cam_systems
@onready var mouse_cam: CameraSystem = cam_systems.get_node_or_null(^"Mouse")

func use():
	if _cooldown > 0.0:
		return
	player.jump_enabled = false
	_active = true
	var cam_dir = Vector3(-sin(player.rotation.y), 0.0, -cos(player.rotation.y))
	var target_vel = player.velocity if !player.wish_dir.is_zero_approx() else cam_dir
	calculate_speed(Utils.flatten_vec(player.velocity).length())
	_current_direction = Utils.flatten_vec(target_vel).normalized()
	_cooldown = info.cooldown
	_elapsed_duration = 0.0
	_used_jump = false
	used.emit()
	cooldown_started.emit()
	
func _physics_process(delta: float) -> void:
	_cooldown -= delta
	if _active:
		if !player.wish_dir.is_zero_approx():
			_current_direction = _current_direction.slerp(player.wish_dir, delta * 2.0)
			
		player.velocity.x = _current_direction.x * _movement_speed
		player.velocity.z = _current_direction.z * _movement_speed
		_elapsed_duration += delta
		if _elapsed_duration >= 3.0:
			_active = false
			player.jump_enabled = true
		if Input.is_action_just_pressed(&"jump") and !_used_jump:
			player.velocity.y = jump_height
			_used_jump = true
		if self.call(&"has_overlapping_bodies") and player.velocity.y < 8.0:
			player.velocity.y += delta * 20.0

func calculate_speed(base_speed: float):
	_movement_speed = max(10.0, base_speed + 2.0)
