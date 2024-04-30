extends Pickup

@export var power = 2000
@onready var anim = $AnimatedSprite2D
@onready var audio = $Pickupaudio

func _ready():
	anim.play("default")
	
	
func apply_effect(player: Player):
	audio.play()
	player.move_force += power
	player.ANGULAR_VELOCITY += 1
	hud.update_score(1)
	hud.speed_upgrade(1)
	await get_tree().create_timer(5.0).timeout
	player.move_force -= power
	player.ANGULAR_VELOCITY -= 1
	hud.speed_upgrade(-1)
