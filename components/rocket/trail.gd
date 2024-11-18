extends Line2D

var queue : Array
var max_length : int = 20
@onready var rocket = get_parent()
func _process(delta):
	if rocket.game_manager.is_paused:
		return
		
	global_position = Vector2(0, 25)
	var pos = get_parent().position
	queue.push_front(pos)
	if queue.size() > max_length:
		queue.pop_back()
	clear_points()
	for point in queue:
		add_point(point)
