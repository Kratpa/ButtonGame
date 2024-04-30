class_name Player
extends RigidBody2D

signal hit

@export var move_force = 1000
@export var spin_force = 50000
@export var MAX_LINEAR_VELOCITY = 500
@export var MAX_ANGULAR_VELOCITY = 500
@export var ANGULAR_VELOCITY = 3.5 # Adjust to change how fast player rotates while moving
@export var blast_force = 1000  # Adjust as needed for blast strength
@export var blast_cooldown_duration = 10

@onready var blast_timer = $BlastCooldownTimer
@onready var cooldown_animation_player = $CooldownAnimationPlayer

var initial_pos: Vector2
var is_on_cooldown = false

# Called when the node enters the scene tree for the first time.
func _ready():
	initial_pos = Vector2(position.x, position.y)
	blast_timer.connect("timeout", Callable(self, "_on_blast_cooldown_timeout"))

func _integrate_forces(state):
	var move_direction = 0
	if Input.is_key_pressed(KEY_RIGHT) or Input.is_key_pressed(KEY_D):
		move_direction += 1
	if Input.is_key_pressed(KEY_LEFT) or Input.is_key_pressed(KEY_A):
		move_direction -= 1

	if move_direction != 0:
		state.apply_central_force(Vector2(move_direction * move_force, 0))
		state.angular_velocity = move_direction * ANGULAR_VELOCITY
	# Check if spacebar is pressed to trigger the blast
	if Input.is_key_pressed(KEY_F):
		emit_blast()

	state.linear_velocity.x = clamp(state.linear_velocity.x, -MAX_LINEAR_VELOCITY, MAX_LINEAR_VELOCITY)
	state.angular_velocity = clamp(state.angular_velocity, -MAX_ANGULAR_VELOCITY, MAX_ANGULAR_VELOCITY)

func on_hit():
	emit_signal("hit")
	linear_velocity = Vector2()
	angular_velocity = 0
	cooldown_animation_player.stop()
	#Engine.time_scale = 0.05
	set_deferred("freeze", true)
	
func emit_blast():
	if is_on_cooldown:
		return  
		
	is_on_cooldown = true  # Set cooldown flag
	blast_timer.start(blast_cooldown_duration)
	
	if cooldown_animation_player:  # Check if not null
		cooldown_animation_player.play("CooldownAnimation")
	
	var bodies = $BlastArea.get_overlapping_bodies()  # Get all bodies in the blast area
	for body in bodies:
		if body is RigidBody2D:
			# Calculate the direction from the player to the object
			var direction = (body.global_position - global_position).normalized()  # Global to avoid rotation effects
			# Apply a strong impulse to push the object away from the player
			body.apply_central_impulse(direction * blast_force)
			
func _on_blast_cooldown_timeout():
	is_on_cooldown = false

func _on_area_2d_body_entered(body):
	if body is Floor2 and rotation_degrees >= -150 and rotation_degrees <= 150:
		return
	on_hit()


func _on_game_game_start():
	linear_velocity = Vector2()
	angular_velocity = 0
	set_deferred("freeze", false)
	rotation = 0
	position = initial_pos
	
