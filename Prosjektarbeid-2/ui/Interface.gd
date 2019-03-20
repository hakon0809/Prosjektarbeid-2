extends CanvasLayer

var ev = InputEventAction.new()

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	ev.set_action("ui_up")
	ev.set_pressed(true)

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_TextureButton_pressed():
	print(ev.as_text())
	Input.parse_input_event(ev)
