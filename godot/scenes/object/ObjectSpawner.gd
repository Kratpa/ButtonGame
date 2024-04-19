extends Node2D

@onready var objects: Node2D = $Objects
@onready var spawn_timer: Timer = $Timer

@export var impulse: Vector2 = Vector2(0, 0)
@export var spawn_interval: float = 2

var object_scene = preload("res://scenes/object/Object.tscn")

func _ready():
	spawn_timer.wait_time = spawn_interval

func _physics_process(delta):
	for node: Node2D in objects.get_children():
		if node.position.y > 1500:
			node.queue_free()

func spawn():
	var object: RigidBody2D = object_scene.instantiate()
	objects.add_child(object)
	object.apply_central_impulse(impulse)
	
	

func _on_timer_timeout():
	spawn()


func _on_player_hit():
	spawn_timer.stop()
	for node: Node2D in objects.get_children():
		node.linear_velocity = Vector2()
		node.set_deferred("freeze", true)
	pass # Replace with function body.


func _on_game_game_start():
	for node: Node2D in objects.get_children():
		node.queue_free()
	spawn_timer.start()
	
