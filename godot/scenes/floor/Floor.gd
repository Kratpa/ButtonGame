extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
	



func _on_body_entered(body):
	body.linear_velocity = Vector2(body.linear_velocity.x, 0)
	body.apply_central_impulse(Vector2(0, -1000))
