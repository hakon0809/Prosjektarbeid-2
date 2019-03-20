extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"
var ev = InputEventAction.new()

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	ev.set_action("ui_up")

func _process(delta):
	if ev.is_pressed():
		print("pressed")
	else:
		print("not pressed")


func _on_TextureButton_pressed():
	ev.set_pressed(true)
	print(ev.as_text())
	Input.parse_input_event(ev)
	ev.set_pressed(false)
