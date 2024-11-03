extends Node2D
class_name LaunchCode

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_code(required_code : Array):
	for i in range(required_code.size()):
		var arrow = get_node("Arrow" + str(i))
		var rotate_amount = 90*required_code[i]
		arrow.rotation_degrees = rotate_amount
		arrow.visible = true
		

func reset():
	for child in get_children():
		child.visible = false
		child.rotation = 0
