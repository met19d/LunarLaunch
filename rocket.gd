extends CharacterBody2D
class_name Rocket

var speed : float = -200.0

var target_speed : float = 0.0

func _ready():
	
	await get_tree().create_timer(3).timeout
	launch()

func _physics_process(delta):
	velocity.y = lerp(velocity.y, target_speed, 0.01)
	move_and_slide()

func launch():
	target_speed = speed
