extends Control
@onready var loot_locker = $"../LootLocker"
@onready var score_node = $"Score_UI/Score"
@onready var submit = $Submit
@onready var line_edit : LineEdit = $LineEdit
# Called when the node enters the scene tree for the first time.
func _ready():
	line_edit.placeholder_text


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
	#if line_edit.text.is_empty():
		#submit.disabled = true
	#else:
		#submit.disabled = false	


func _on_submit_pressed():
	loot_locker._upload_score(get_parent().score)
	loot_locker._change_player_name(line_edit.get_text())
	var game_over_ui = $"../GameOverUI"
	game_over_ui.show()
	
	hide()
	
func set_score_text(inputscore):
	score_node.text = str(inputscore)
