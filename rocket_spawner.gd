extends Node2D

var max_spawn = 5
var spawn_tick = 0
var spawn_rate = 5
var rocket = preload("res://components/rocket/rocket.tscn")
var is_active = false
@export var launch_codes : Node2D
var spawn_locations = {0: Vector2(-224,40), 1: Vector2(-112,40), 2: Vector2(0,40), 3: Vector2(112,40),  4: Vector2(224,40)}
func _ready():
	spawn_tick = spawn_rate


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !is_active:
		return
	for child in get_children():
		child.set_process(is_active)
	if spawn_tick > 0:
		spawn_tick -= delta
	else:
		if get_child_count() <= max_spawn:
			spawn()
			if get_child_count() < max_spawn and spawn_rate < 4:
				var rand = randi_range(0, 10)
				if spawn_rate < .5:
					rand += 1
				#second spawn
				if rand > 4:
					spawn()
					#tripple spawn
					if get_child_count() < max_spawn - 1:
						if rand > 5 and spawn_rate < 4:
							spawn()
			
		spawn_tick = spawn_rate

func spawn():
	if get_child_count() > 4:
		return
		
	if spawn_rate > 0.5:
		spawn_rate -= 0.25
	if get_parent().score >= 2000:
		spawn_rate = 0.001
	elif get_parent().score >= 900:
		spawn_rate = 0.01
	elif get_parent().score >= 750:
		spawn_rate = 0.1
		
	var current_children = get_children()
	var available_spawn_points = []
	for i in range(0, 5):
		var available = true
		for child in current_children:
			if child.global_position.x == spawn_locations[i].x and child.global_position.y > -50:
				available = false
		if available:
			available_spawn_points.append(i)		
	var rand = randi_range(0, 5)
	while(rand not in available_spawn_points):
		rand = randi_range(0, 5)	
	var instance : Rocket = rocket.instantiate()
	while(true):
		var instance_code: Array = instance.get_code()
		var contains_subarray : bool = false	
		for child: Rocket in get_children():
			var child_code: Array = child.get_code()
			if child_code.size() > instance_code.size():
				contains_subarray = is_subarray(child_code, instance_code)
			if contains_subarray:
				break
		if !contains_subarray:
			break
		instance.create_code()
	add_child(instance)
	instance.position = spawn_locations[rand]
	instance.location_id = rand
	var launch_code: LaunchCode = launch_codes.get_node("LaunchCode"+str(instance.location_id))
	launch_code.set_code(instance.get_code())
	
func toggle_active(active : bool):
	is_active = active
	if !active:
		clear_rockets()
	
func clear_rockets():
	for child : Rocket in get_children():
		child.destroy()
	for i in range(0, 5):
		var launch_code: LaunchCode = launch_codes.get_node("LaunchCode"+str(i))
		launch_code.reset()

#checks if B is subarray of A
func is_subarray(A: Array, B: Array) -> bool:
	var n = A.size()
	var m = B.size()

	for i in range(n - m + 1):
		var is_match = true
		for j in range(m):
			if A[i + j] != B[j]:
				is_match = false
				break
		if is_match:
			return true  # Subarray found
	return false  # Subarray not found
