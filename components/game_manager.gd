extends Node2D


var input_queue : Array = []
enum {LEFT, UP, RIGHT, DOWN}
@export var input_display : Node2D

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
		

func _input(event):
	if event.is_action_pressed("ui_up"):
		input_queue.append(UP)
		print_debug("ui_up")
	if event.is_action_pressed("ui_down"):
		input_queue.append(DOWN)
		print_debug("ui_down")
	if event.is_action_pressed("ui_left"):
		input_queue.append(LEFT)
		print_debug("ui_left")
	if event.is_action_pressed("ui_right"):
		input_queue.append(RIGHT)
		print_debug("ui_right")
	if input_queue.size() > 4:
		var start_input = input_queue[4]
		reset_input()
		input_queue.append(start_input)
	
	for i in range(input_queue.size()):
		var arrow : Sprite2D = input_display.get_node("Arrow" + str(i))
		arrow.visible = true
		var rotate_amount = 90*input_queue[i]
		
		arrow.rotation_degrees = rotate_amount
		print_debug(arrow.rotation)
	
	var rockets = get_all_rockets()
	var rockets_launched = false
	for rocket in rockets:
		if rocket.required_combo == input_queue:
			rocket.launch()
			rockets_launched = true
	if rockets_launched:
		reset_input()	

func get_all_rockets():
	return get_node("Rockets").get_children()

func reset_input():
	input_queue.clear()
	for child in input_display.get_children():
		child.visible = false
		child.rotation = 0
