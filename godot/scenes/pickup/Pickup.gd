class_name Pickup
extends Area2D

var hud: HUD

# Called when the node enters the scene tree for the first time.
func _ready():
	body_entered.connect(_on_body_entered)
	pass # Replace with function body.

func apply_effect(player: Player):
	pass
	

	
func _on_body_entered(body: Node2D):
	if !visible:
		return
	if body is Player:
		visible = false
		await apply_effect(body)
		queue_free()
	else:
		print("WARN: Pickup collision handled by non Player node:", body)


