class_name Floor2
extends RigidBody2D


@onready var bouncesound = $BounceAudio
var last_hit = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_body_entered(body: RigidBody2D):
	if body is Player:
		bouncesound.play()
		var current_time = Time.get_ticks_msec()
		if current_time - last_hit <= 100:
			return
		last_hit = current_time
	body.linear_velocity = Vector2(body.linear_velocity.x, 0)
	body.apply_central_impulse(Vector2(0, -1000 * body.mass))
