extends Node2D

@onready var objects: Node2D = $Objects

var object_scene = preload("res://scenes/object/Object.tscn")

func _physics_process(delta):
	for node: Node2D in objects.get_children():
		if node.position.y > 1500:
			node.queue_free()

func spawn():
	var object: RigidBody2D = object_scene.instantiate()
	objects.add_child(object)
	object.apply_central_impulse(Vector2(-100, 0))
	
	

func _on_timer_timeout():
	spawn()
