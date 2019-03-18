extends Container

onready var content = preload("res://menus/choices/MenuText.gd")
onready var setting = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Setting
onready var button = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Button
onready var popup = $PanelContainer/VBoxContainer/MarginContainer/PopupPanel
var active
var actives
var level
var parent
var settings_menu = false

func _ready():
	popup.hide()
	setting.set_text(content.SETTING[level-1])
	button.pressed = active


func _on_SaveButton_pressed():
	if active:
		parent.save_setting(level, active)
	else:
		popup.show()
	
func _on_Button_toggled(button_pressed):
	if active:
		active = false
	else:
		active = true

func _on_YesButton_pressed():
	popup.hide()
	parent.save_setting(level, active)


func _on_NoButton_pressed():
	popup.hide()

