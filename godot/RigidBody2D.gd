extends RigidBody2D

func _ready():
	# Randomly set the initial position at the top of the screen
	position.x = randf_range(0, get_viewport_rect().size.x)
	position.y = -50  # Place above the top edge of the screen

	# Apply gravity to make the square fall
	gravity_scale = 1.0  # Adjust gravity scale as needed
	linear_velocity.y = 200  # Set initial falling speed

func _process(delta):
	# Check if the square has gone below the screen and remove it
	if position.y > get_viewport_rect().size.y:
		queue_free() # Remove the square from the scene
