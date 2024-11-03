extends Node2D

var max_spawn = 5
var spawn_tick = 0
var spawn_rate = 5
var rocket = preload("res://components/rocket/rocket.tscn")

var spawn_locations = {0: Vector2(0,40), 1: Vector2(-125,40), 2: Vector2(125,40), 3: Vector2(-216,40), 4: Vector2(216,40)}
func _ready():
	spawn_tick = spawn_rate


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if spawn_tick > 0:
		spawn_tick -= delta
	else:
		if get_child_count() <= max_spawn:
			spawn()
		spawn_tick = spawn_rate

func spawn():
	if get_child_count() > 4:
		return
	var current_children = get_children()
	var available_spawn_points = []
	for i in range(0, 5):
		var available = true
		for child in current_children:
			if child.global_position == spawn_locations[i]:
				available = false
		if available:
			available_spawn_points.append(i)		
		
	var rand = randi_range(0, 5)
	while(rand not in available_spawn_points):
		rand = randi_range(0, 5)	
		
	var instance = rocket.instantiate()
	add_child(instance)
	instance.position = spawn_locations[rand]
		
