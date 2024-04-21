extends Node2D

@onready var objects: Node2D = $Objects
@onready var spawn_timer: Timer = $Timer

@export var impulse: Vector2 = Vector2(0, 0)
@export var spawn_interval: float = 2

@onready var current_spawn_interval = spawn_interval

var object_scene = preload("res://scenes/object/Object.tscn")

var elapsed = 0

var freezed = false

var objects_spawned = 0

func _physics_process(delta):
	
	for node: Node2D in objects.get_children():
		if node.position.y > 1500:
			node.queue_free()
	if !freezed:
		elapsed += delta
		if elapsed >= current_spawn_interval:
			spawn()
			elapsed = 0

func spawn():
	var object: RigidBody2D = object_scene.instantiate()
	objects.add_child(object)
	var y_implulse = impulse.y
	if objects_spawned % 2 != 0:
		y_implulse += -100
	object.apply_central_impulse(Vector2(impulse.x, y_implulse))
	objects_spawned += 1
	
func level_up(level: int):
	if current_spawn_interval <= 0.5:
		return
	var delta = 0.5
	if current_spawn_interval <= 1.0:
		delta = 0.1
	current_spawn_interval -= delta
	

func _on_player_hit():
	freezed = true
	for node: Node2D in objects.get_children():
		node.linear_velocity = Vector2()
		node.set_deferred("freeze", true)
	pass # Replace with function body.


func _on_game_game_start():
	for node: Node2D in objects.get_children():
		node.queue_free()
	current_spawn_interval = spawn_interval
	freezed = false
	objects_spawned = 0
	
