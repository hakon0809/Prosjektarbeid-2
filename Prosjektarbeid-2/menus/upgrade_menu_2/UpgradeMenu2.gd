extends Container

onready var popup = $MarginContainer/PanelContainer/Popup
onready var scenes = $MarginContainer/PanelContainer/VBoxContainer/SceneContainer

func _ready():
	popup.hide()

func _on_ExitButton_pressed():
	popup.show()