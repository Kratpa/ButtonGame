extends Node2D
var score

@onready var player = $Player
@onready var floor = $Floor


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func game_over():
	$ScoreTimer.stop()
	$HUD.show_game_over()
	player.hide()

func new_game():
	score = 30
	$ScoreTimer.start()
	$HUD.update_score(score)
	player.show()
	player.reset = true
	

func _on_score_timer_timeout():
	score -= 1
	print(score)
	$HUD.update_score(score)
	if score == 0:
		$HUD/Message.text = "Level completed!"
		$HUD/ScoreLabel.hide()
		$HUD/Message.show()
		$HUD/StartButton.text = "Next"
		$HUD/StartButton.show()
	


func _on_player_hit():
	game_over()
