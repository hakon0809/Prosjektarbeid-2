extends Container

onready var popup = $MarginContainer/PanelContainer/Popup
onready var scenes = $MarginContainer/PanelContainer/VBoxContainer/SceneContainer

func _ready():
	popup.hide()

func _on_ExitButton_pressed():
	popup.scene = self
	popup.show()
	
func save_changes(active):
	#save changes
	self.queue_free()
