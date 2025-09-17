extends Node3D

@export var speed: float = 5.0  # Base movement speed
@export var mouse_sensitivity: float = 0.002  # Mouse look sensitivity
@export var max_pitch: float = 1.5  # Limit vertical look (in radians, ~85 degrees)

var velocity: Vector3 = Vector3.ZERO
@onready var camera: Camera3D = $"."  # Main camera

func _ready():
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)  # Hide and capture mouse
	# Reset rotations to ensure no roll
	camera.rotation = Vector3.ZERO

func _input(event):
	if event is InputEventMouseMotion:
		# Yaw: Rotate YawNode around global Y-axis
		rotate_y(-event.relative.x * mouse_sensitivity)
		# Pitch: Rotate main camera around its local X-axis
		camera.rotate_x(-event.relative.y * mouse_sensitivity)
		camera.rotation.x = clamp(camera.rotation.x, -max_pitch, max_pitch)
		camera.rotation.z = 0.0  # Lock roll

	if Input.is_action_just_pressed("ui_cancel"):  # ESC to release mouse
		Input.set_mouse_mode(Input.MOUSE_MODE_VISIBLE)

func _physics_process(delta):
	var input_dir = Vector3.ZERO
	
	# Keyboard input for movement (WASD + QE for up/down)
	if Input.is_action_pressed("forward"):
		input_dir -= transform.basis.z  # Forward: Negative Z in local space
	if Input.is_action_pressed("backward"):
		input_dir += transform.basis.z  # Backward: Positive Z
	if Input.is_action_pressed("left"):
		input_dir -= transform.basis.x  # Strafe left: Negative X
	if Input.is_action_pressed("right"):
		input_dir += transform.basis.x  # Strafe right: Positive X
	if Input.is_action_pressed("up"):
		input_dir += Vector3.UP  # Up: Global Y
	if Input.is_action_pressed("down"):
		input_dir -= Vector3.UP  # Down: Global Y
	
	# Normalize to prevent faster diagonal movement
	if input_dir.length() > 0:
		input_dir = input_dir.normalized()
	
	# Apply speed and delta for frame-rate independent movement
	velocity = input_dir * speed * delta
	global_position += velocity
