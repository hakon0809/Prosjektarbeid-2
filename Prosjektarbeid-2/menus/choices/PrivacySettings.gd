extends Container

onready var content = preload("res://menus/choices/MenuText.gd")
onready var setting = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Setting
onready var button = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Button
onready var popup = $PanelContainer/VBoxContainer/MarginContainer/PopupPanel
var active
var option
var parent
var level

func _ready():
	popup.hide()
	setting.set_text(content.SETTING[level-1])
	button.pressed = active


func _on_SaveButton_pressed():
	if active:
		parent.save_activity(level, "save_on")
		parent.save_setting(option, active)
	else:
		popup.show()
	
func _on_Button_toggled(button_pressed):
	if active:
		active = false
	else:
		active = true

func _on_YesButton_pressed():
	popup.hide()
	parent.save_activity(level, "save_off")
	parent.save_setting(option, active)


func _on_NoButton_pressed():
	parent.save_activity(level, "undo")
	popup.hide()

