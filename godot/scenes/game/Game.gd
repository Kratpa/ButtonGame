extends Node2D
var time_alive
var level = 1


signal game_start
signal level_up(level: int)

@onready var player = $Player
@onready var floor = $Floor
@onready var hud = $HUD
@onready var object_spawner = $ObjectSpawner
@onready var parallax = $ParallaxBackground
@onready var viewport_width = get_viewport_rect().size.x


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_x = player.position.x
	var viewport_center = viewport_width / 2
	var offset = player_x - viewport_center
	parallax.scroll_offset.x = -offset * 0.2


func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()

func new_game():
	time_alive = 0
	level = 0
	game_start.emit()
	$ScoreTimer.start()
	hud.update_level(level)
	hud.update_score(time_alive)
	

func _on_score_timer_timeout():
	time_alive += 1
	hud.update_score(time_alive)
	if time_alive > 0 and time_alive % 10 == 0:
		level += 1
		hud.update_level(level)
		object_spawner.level_up(level)

func _on_player_hit():
	game_over()
	
func _on_world_boundary_body_entered(body):
	if body is Player:
		player.on_hit()
	else:
		body.queue_free()
