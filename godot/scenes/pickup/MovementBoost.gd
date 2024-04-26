extends Pickup

@export var power = 2000
@onready var anim = $AnimatedSprite2D
@onready var audio = $Pickupaudio
func _ready():
	anim.play("default")

func _draw():
	draw_circle(Vector2(), 10, Color.AQUAMARINE)
	
	
func apply_effect(player: Player):
	audio.play()
	player.move_force += power
	await get_tree().create_timer(5.0).timeout
	player.move_force -= power
