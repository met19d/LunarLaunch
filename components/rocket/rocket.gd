extends CharacterBody2D
class_name Rocket

var speed : float = -250.0
var target_speed : float = 0.0
var required_combo : Array = []
var location_id : int = 0
var is_flying = false
var timer = 0
var max_time = 5
@onready var game_manager = get_node("/root/GameManager")
@onready var camera : MainCamera = get_node("/root/GameManager/MainCamera")
@onready var trail : Line2D = get_node("Trail")


func _ready():
	create_code()
	timer = max_time
		
func _physics_process(delta):
	if game_manager.is_paused:
		return
	if global_position.y < -550:
		print_debug("released")
		queue_free()
	if timer > 0:
		timer -= delta
	elif !is_flying:
		game_manager.remove_life(location_id)
		destroy()
	velocity.y = lerp(velocity.y, target_speed, 0.005)
	move_and_slide()

func create_code():
	var code_size = randi_range(2,4)
	for i in range(0, code_size):
		var rand = randi_range(0, 3)
		required_combo.append(rand)

func launch():
	AudioManager.launch_sfx.play()
	target_speed = speed
	is_flying = true

func get_code():
	return required_combo

func destroy():
	AudioManager.explosion_sfx.play()
	camera.apply_shake(10, 12)
	queue_free()
