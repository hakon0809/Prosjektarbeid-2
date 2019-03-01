extends Node

onready var content = preload("res://menus/choices/MenuText.gd")
onready var setting = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Setting
onready var button = $PanelContainer/VBoxContainer/MarginContainer/VBoxContainer/HBoxContainer/Button
var active
var level
var parent

func _ready():
	setting.set_text(content.SETTING[level-1])
	if active:
		button.pressed = true
	else:
		button.pressed = false

func _on_SaveButton_pressed():
	parent.save_setting(active)

func _on_Button_button_up():
	active = false


func _on_Button_button_down():
	active = true
