extends Pickup

@onready var anim = $AnimatedSprite2D
@onready var audio = $Pickupaudio

func _ready():
	anim.play("default")
	
	
func apply_effect(player: Player):
	audio.play()
	player.force_field.add()
	hud.update_score(1)
	await get_tree().create_timer(5.0).timeout
	player.force_field.remove()
