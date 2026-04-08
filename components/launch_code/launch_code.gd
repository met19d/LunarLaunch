extends Node2D
class_name LaunchCode

@export var text_label : RichTextLabel
func _ready():
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func set_code(required_code : String):
	text_label.text = "[center]" + required_code + "[/center]"
	text_label.visible = true

func reset():
	for child in get_children():
		child.visible = false
		child.rotation = 0
		text_label.text = ""
