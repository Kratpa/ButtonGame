extends CanvasLayer

signal start_game

@onready var start = $StartGame
@onready var end = $EndGame

func _on_start_button_pressed():
	emit_signal("start_game")
	start.hide()
	end.hide()
	
func _on_exit_button_pressed():
	get_tree().quit()
