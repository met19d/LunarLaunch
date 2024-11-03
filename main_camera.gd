class_name MainCamera
extends Camera2D


@export var rand_strength: float
@export var shake_fade_speed: float
var shake_strength: float = 0.0

func _ready():
	position = Vector2.ZERO

func _process(delta):	
	if shake_strength > 0:
		shake_strength = lerpf(shake_strength, 0, shake_fade_speed*delta)
		
		offset = random_offset()

func apply_shake(shake_strength : float = 20.0, shake_fade_speed: float = 12.0):
	self.shake_strength = rand_strength
	self.shake_strength = shake_strength
	self.shake_fade_speed = shake_fade_speed


func random_offset() -> Vector2:
	return Vector2(randf_range(-shake_strength, shake_strength), randf_range(-shake_strength, shake_strength))
