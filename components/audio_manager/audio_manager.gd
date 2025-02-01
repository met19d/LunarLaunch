extends Node2D
@onready var clear_sfx = $ClearSFX
@onready var main_theme = $MainTheme
@onready var explosion_sfx = $ExplosionSFX
@onready var select_sfx = $SelectSFX
@onready var launch_sfx = $LaunchSFX
@onready var success = $Success
@onready var multi = $Multi
@onready var check_box : CheckBox = $"../CheckBox"


func _on_check_box_toggled(toggled_on):
	AudioServer.set_bus_mute(AudioServer.get_bus_index("Master"), !toggled_on)

func _ready():
	if AudioServer.is_bus_mute(AudioServer.get_bus_index("Master")):
		check_box.button_pressed = false
