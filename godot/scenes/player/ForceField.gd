extends StaticBody2D

var additions = 0
	
func _draw():
	draw_circle(Vector2(), 120, Color(1, 1, 1, 0.05))


func add():
	additions += 1
	visible = true
	process_mode = Node.PROCESS_MODE_INHERIT
	
	
func remove():
	additions -= 1
	if additions <= 0:
		visible = false
		process_mode = Node.PROCESS_MODE_DISABLED
