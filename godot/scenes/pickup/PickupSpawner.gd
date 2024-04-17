extends Node

var movement_boost_scene = preload("res://scenes/pickup/MovementBoost.tscn")

var current_instance: Pickup
# Called when the node enters the scene tree for the first time.
func _ready():
	var timer = Timer.new()
	add_child(timer)
	timer.start(5)
	timer.timeout.connect(_spawn)
	
	
func _spawn():
	if current_instance != null and current_instance.visible == true:
		current_instance.queue_free()
	var instance: Pickup = movement_boost_scene.instantiate()
	instance.position = Vector2(50 + randi() % (get_viewport().size.x - 50), 200 + randi() % (get_viewport().size.y - 200))
	current_instance = instance
	add_child(instance)

