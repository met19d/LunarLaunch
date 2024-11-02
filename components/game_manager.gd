extends Node2D


var input_queue : Array = []
enum {LEFT, RIGHT, UP, DOWN}

func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	print_debug(input_queue)

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
		input_queue.clear()
		input_queue.append(start_input)
	
	var rockets = get_all_rockets()
	var rockets_launched = false
	for rocket in rockets:
		if rocket.required_combo == input_queue:
			rocket.launch()
			rockets_launched = true
	if rockets_launched:
		input_queue.clear()	

func get_all_rockets():
	return get_node("Rockets").get_children()
