extends CharacterBody3D


const SPEED = 5.0
const GROUND_ACCEL = 0.1
const JUMP_VELOCITY = 4.5


func _physics_process(delta: float) -> void:
    if not is_on_floor():
        velocity += get_gravity() * delta

    if Input.is_action_just_pressed("jump") and is_on_floor():
        velocity.y = JUMP_VELOCITY

    var input_dir := Input.get_vector("left", "right", "forward", "backward")
    var direction := Vector3(input_dir.x, 0, input_dir.y).rotated(Vector3.UP, $CameraSystem.rotation.y)
    velocity.x = lerp(velocity.x, direction.x * SPEED, GROUND_ACCEL)
    velocity.z = lerp(velocity.z, direction.z * SPEED, GROUND_ACCEL)

    move_and_slide()
