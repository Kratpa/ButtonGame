extends Node2D
var score = 0
var level = 1


signal game_start
signal level_up(level: int)

@onready var player = $Player
@onready var floor = $Floor
@onready var hud = $HUD
@onready var object_spawner = $ObjectSpawner
@onready var parallax = $ParallaxBackground
@onready var viewport_width = get_viewport_rect().size.x
@onready var bgmusic = $BGMusic
@onready var startmusic = $Startsong
@onready var cooldown_icon = $HUD/CooldownIcon

func randomsong():
	var songnr = randi_range(0, 1)
	if songnr == 0:
		startmusic.play()
	else:
		bgmusic.play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var player_x = player.position.x
	var viewport_center = viewport_width / 2
	var offset = player_x - viewport_center
	parallax.scroll_offset.x = -offset * 0.2


func game_over():
	$HUD.show_game_over()
	bgmusic.stop()
	startmusic.stop()
	

func new_game():
	score = 0
	level = 1
	game_start.emit()
	hud.update_level(level)
	hud.reset_score()
	randomsong()
	cooldown_icon.visible = true
	cooldown_icon.modulate.a = 1
	

func _on_bounce():
	score += 1
	hud.update_score(1)
	if score > 0 and score % 10 == 0:
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
