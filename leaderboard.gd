extends Control
class_name LeaderBoard
var json
# Called when the node enters the scene tree for the first time.
@onready var loot_locker = $"../../LootLocker"

func _ready():
	pass

func _on_loot_locker_update_board():
	json = loot_locker.current_board
	for n in json.get_data().items.size():
		var rank_entry = get_node("VBoxContainer/HBoxContainer/Ranks/Label"+str(n+1))
		var name_entry = get_node("VBoxContainer/HBoxContainer/PlayerNames/Label"+str(n+1))
		var score_entry = get_node("VBoxContainer/HBoxContainer/Scores/Label"+str(n+1))
		rank_entry.text = str(json.get_data().items[n].rank)
		name_entry.text = str(json.get_data().items[n].player.name)
		score_entry.text = str(json.get_data().items[n].score)
		if n >= 4:
			break
