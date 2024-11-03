extends Node2D


var input_queue : Array = []
enum {LEFT, UP, RIGHT, DOWN}
@export var input_display : Node2D
@export var launch_codes : Node2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func _input(event):
	if event.is_action_pressed("ui_up"):
		input_queue.append(UP)
	if event.is_action_pressed("ui_down"):
		input_queue.append(DOWN)
	if event.is_action_pressed("ui_left"):
		input_queue.append(LEFT)
	if event.is_action_pressed("ui_right"):
		input_queue.append(RIGHT)
	if event.is_action_pressed("clear"):
		reset_input()
	if input_queue.size() > 4:
		var start_input = input_queue[4]
		reset_input()
		input_queue.append(start_input)
	
	for i in range(input_queue.size()):
		var arrow : Sprite2D = input_display.get_node("Arrow" + str(i))
		arrow.visible = true
		var rotate_amount = 90*input_queue[i]
		arrow.rotation_degrees = rotate_amount
	
	var rockets = get_all_rockets()
	var rockets_launched = false
	for rocket in rockets:
		if rocket.required_combo == input_queue:
			rocket.launch()
			rockets_launched = true
			var launch_code : LaunchCode = launch_codes.get_node("LaunchCode"+str(rocket.location_id))
			launch_code.reset()
	if rockets_launched:
		reset_input()	

func get_all_rockets():
	return get_node("Rockets").get_children()

func reset_input():
	input_queue.clear()
	for child in input_display.get_children():
		child.visible = false
		child.rotation = 0
