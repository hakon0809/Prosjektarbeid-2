extends Node

onready var content = preload("res://menus/choices/MenuText.gd")
onready var choice = $PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/InfoContainer/CheckButton
var level
var parent
var active = false

func _ready():
	choice.set_text(content.SETTING[level-1])
	if active:
		choice.pressed = true
	else:
		choice.pressed = false

func _on_SaveButton_pressed():
	self.queue_free()
	parent.save_setting(active)