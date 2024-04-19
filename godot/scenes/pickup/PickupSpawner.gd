extends Node

var movement_boost_scene = preload("res://scenes/pickup/MovementBoost.tscn")
var timer: Timer
var current_instance: Pickup
# Called when the node enters the scene tree for the first time.
func _ready():
	timer = Timer.new()
	add_child(timer)
	timer.wait_time = 5
	timer.timeout.connect(_spawn)
	
	
func _spawn():
	if current_instance != null and current_instance.visible == true:
		current_instance.queue_free()
	var instance: Pickup = movement_boost_scene.instantiate()
	instance.position = Vector2(50 + randi() % (get_viewport().size.x - 50), 200 + randi() % (get_viewport().size.y - 200))
	current_instance = instance
	add_child(instance)



func _on_player_hit():
	timer.stop()


func _on_game_game_start():
	timer.start()
	if current_instance != null:
		current_instance.queue_free()
	pass # Replace with function body.
