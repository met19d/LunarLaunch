extends CharacterBody2D
class_name Rocket

var speed : float = -250.0
var target_speed : float = 0.0
var required_combo : Array = []
var location_id : int = 0

func _ready():
	var code_size = randi_range(2,4)
	for i in range(0, code_size):
		var rand = randi_range(0, 3)
		required_combo.append(rand)
	print_debug(required_combo)
		
func _physics_process(delta):
	velocity.y = lerp(velocity.y, target_speed, 0.005)
	move_and_slide()

func launch():
	target_speed = speed
	await await get_tree().create_timer(4).timeout
	print_debug("deleting")
	queue_free()

func get_code():
	return required_combo
