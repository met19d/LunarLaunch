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

func play_sfx(stream: AudioStream):
	var instance : AudioStreamPlayer = AudioStreamPlayer.new()
	instance.stream = stream
	instance.volume_db = -5
	instance.pitch_scale = randf_range(0.75, 0.85)
	instance.finished.connect(instance.queue_free)
	add_child(instance)
	instance.play()

func play_delete_sfx():
	var instance : AudioStreamPlayer = AudioStreamPlayer.new()
	instance.stream = $SelectSFX.stream
	instance.volume_db = -5
	instance.pitch_scale = randf_range(0.55, 0.65)
	instance.finished.connect(instance.queue_free)
	add_child(instance)
	instance.play()
