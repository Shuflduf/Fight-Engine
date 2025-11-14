extends Node3D

@onready var cam: Camera3D = %Camera3D
@onready var cam_system: Node3D = $".."
@onready var player: CharacterBody3D = $"../.."

const VERTICAL_SWAY_SPEED = 12.0
const HORIZONTAL_SWAY_SPEED = 6.0

var sway_progress = 0.0

func _process(delta: float) -> void:
    var should_sway = player.is_moving && player.is_on_floor()
    if should_sway:
        var transition_progress = min(sway_progress, 1.0)
        sway_progress += delta
        position.y = lerp(position.y, cos(sway_progress * VERTICAL_SWAY_SPEED) / 5.0, transition_progress)
        position.x = lerp(position.x, sin(sway_progress * HORIZONTAL_SWAY_SPEED) / 5.0, transition_progress)

        rotation.y = sin(sway_progress * HORIZONTAL_SWAY_SPEED) / 50.0
    else:
        position = position.lerp(Vector3.ZERO, delta * 5)
        rotation.y = lerp(rotation.y, 0.0, delta * 5)
        sway_progress = 0.0
