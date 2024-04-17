class_name Player
extends RigidBody2D

@export var move_force = 1000
@export var spin_force = 50000
@export var MAX_LINEAR_VELOCITY = 500
@export var MAX_ANGULAR_VELOCITY = 500

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
		state.apply_central_force(Vector2(move_force, 0))
	if Input.is_key_pressed(KEY_LEFT):
		state.apply_central_force(Vector2(-move_force, 0))
	if Input.is_key_pressed(KEY_UP) or Input.is_key_pressed(KEY_A):
		state.apply_torque(-spin_force)
	if Input.is_key_pressed(KEY_DOWN) or Input.is_key_pressed(KEY_D):
		state.apply_torque(spin_force)
		
	state.linear_velocity.x = clamp(state.linear_velocity.x, -MAX_LINEAR_VELOCITY, MAX_LINEAR_VELOCITY)
	state.angular_velocity = clamp(state.angular_velocity, -MAX_ANGULAR_VELOCITY, MAX_ANGULAR_VELOCITY)
	
	if reset:
		state.transform = Transform2D(0.0, initial_pos)
		state.linear_velocity = Vector2()
		state.angular_velocity = 0
		reset = false

