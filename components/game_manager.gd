extends Node2D


var input_queue : Array = []
enum {LEFT, UP, RIGHT, DOWN}
@onready var input_display : Node2D = get_node("InputDisplay")
@onready var launch_codes : Node2D = get_node("LaunchCodes")
@onready var score_label : Label  = get_node("Hud/Score_UI/Score")
@onready var camera : MainCamera = get_node("MainCamera")
@onready var hud : TextureRect = get_node("Hud")
@onready var game_over : Control = get_node("GameOverUI")
@onready var highscore_screen = $HighscoreScreen
var score = 0
@onready var lives = 1
@onready var lives_label : Label = get_node("Hud/Lives/Lives")
@onready var rocket_spawner = $Rockets
@onready var loot_locker = $LootLocker

func _ready():
	loot_locker.player_id = OS.get_unique_id()
	
	loot_locker._authentication_request()
	
	score_label.text = str(score)
	lives_label.text = str(lives)
	AudioManager.main_theme.play()
	rocket_spawner.toggle_active(true)
	game_over.visible = false

func _process(delta):
	pass
		

func _input(event):
	var pitch 
	if event.is_action_pressed("ui_up"):
		play_select_sfx()
		input_queue.append(UP)
	if event.is_action_pressed("ui_down"):
		play_select_sfx()
		input_queue.append(DOWN)
	if event.is_action_pressed("ui_left"):
		play_select_sfx()
		input_queue.append(LEFT)
	if event.is_action_pressed("ui_right"):
		play_select_sfx()
		input_queue.append(RIGHT)
	if event.is_action_pressed("clear"):
		if input_queue.size() != 0:
			AudioManager.clear_sfx.play()
			camera.apply_shake(5, 14)
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
		if rocket.required_combo == input_queue and !rocket.is_flying:
			rocket.launch()
			score_increase(10)
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

func score_increase(amount):
	score += amount
	score_label.text = str(score)

func remove_life(location):
	lives -= 1
	lives_label.text = str(lives)
	var launch_code : LaunchCode = launch_codes.get_node("LaunchCode"+str(location))
	launch_code.reset()
	if lives == 0:
		loot_locker._get_leaderboards()
		hud.visible = false
		rocket_spawner.toggle_active(false)
		var previous = loot_locker.player_score
		if score > loot_locker.player_score:	
			highscore_screen.visible = true
			highscore_screen.set_score_text(score)
		else:
			game_over.visible = true
	

func play_select_sfx():
	AudioManager.select_sfx.pitch_scale = randf_range(0.65, 0.75)
	AudioManager.select_sfx.play()

func _on_retry_pressed():
	get_parent().get_tree().reload_current_scene() 
