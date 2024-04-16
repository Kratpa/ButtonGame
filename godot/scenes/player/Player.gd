extends RigidBody2D

const MOVE_FORCE = 1000
const MAX_VELOCITY = 500

var reset = false
var initial_pos: Vector2

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_pos = Vector2(position.x, position.y)
	
func _physics_process(delta):
	if position.y > 1000:
		reset = true

func _integrate_forces(state):
	if Input.is_key_pressed(KEY_RIGHT):
		state.apply_central_force(Vector2(MOVE_FORCE, 0))
	if Input.is_key_pressed(KEY_LEFT):
		state.apply_central_force(Vector2(-MOVE_FORCE, 0))
	state.linear_velocity.x = clamp(state.linear_velocity.x, -MAX_VELOCITY, MAX_VELOCITY)
	
	if reset:
		state.transform = Transform2D(0.0, initial_pos)
		state.linear_velocity = Vector2()
		state.angular_velocity = 0
		reset = false
