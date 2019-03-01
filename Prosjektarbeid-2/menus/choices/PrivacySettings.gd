extends Container

onready var content = preload("res://menus/choices/MenuText.gd")
onready var setting = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Setting
onready var button = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Button
onready var popup = $PanelContainer/VBoxContainer/MarginContainer/PopupPanel
var active
var level
var parent

func _ready():
	popup.hide()
	setting.set_text(content.SETTING[level-1])
	if active:
		button.pressed = true
	else:
		button.pressed = false

func _on_SaveButton_pressed():
	if active:
		parent.save_setting(active)
	else:
		popup.show()
	
func _on_Button_toggled(button_pressed):
	if active:
		active = false
	else:
		active = true

func _on_YesButton_pressed():
	popup.hide()
	parent.save_setting(active)


func _on_NoButton_pressed():
	popup.hide()

