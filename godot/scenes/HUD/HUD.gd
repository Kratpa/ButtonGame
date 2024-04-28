class_name HUD
extends Control

# Notifies `Game` node that the button has been pressed
signal start_game

var speed = 0
var score = 0

func show_message(text):
	$Message.text = text
	$Message.show()
	
	
func show_game_over():
	show_message("Game Over")
	$StartButton.show()
	$Message2.show()
	
func update_score(delta):
	self.score += delta
	$ScoreLabel.text = str(self.score)
	
func reset_score():
	self.score = 0
	$ScoreLabel.text = str(self.score)
	
func update_level(level):
	$LevelLabel.text = "Level: " + str(level)
	
func speed_upgrade(amount: int):
	speed = speed + amount
	if speed == 0:
		$SpeedLabel.visible = false
		return
	$SpeedLabel.visible = true
	$SpeedLabel.text = "Speed: +" + str(speed) 
	
func _on_start_button_pressed():
	$StartButton.hide()
	start_game.emit()
	$Message.hide()
	$Message2.hide()
	$ScoreLabel.show()
	$LevelLabel.show()
	speed = 0
