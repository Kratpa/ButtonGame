extends Node2D
var score

signal game_start

@onready var player = $Player
@onready var floor = $Floor


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()

func new_game():
	score = 30
	game_start.emit()
	$ScoreTimer.start()
	$HUD.update_score(score)
	

func _on_score_timer_timeout():
	score -= 1
	$HUD.update_score(score)
	if score == 0:
		$HUD/Message.text = "Level completed!"
		$HUD/ScoreLabel.hide()
		$HUD/Message.show()
		$HUD/StartButton.text = "Next"
		$HUD/StartButton.show()
	


func _on_player_hit():
	game_over()


func _on_world_boundary_body_entered(body):
	print("world boundary hit", body)
	player.on_hit()
