extends CharacterBody2D
class_name Rocket

var speed : float = -180.0
var target_speed : float = 0.0
var required_combo : Array = [0, 1, 2, 3]

func _ready():
	pass
func _physics_process(delta):
	velocity.y = lerp(velocity.y, target_speed, 0.01)
	move_and_slide()

func launch():
	target_speed = speed
	await await get_tree().create_timer(4).timeout
	print_debug("deleting")
	queue_free()
