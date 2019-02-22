extends Node

var option
onready var choice = get_node(
		"PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/InfoContainer/CheckButton")

func _ready():
	#TODO option = chosen
	option = ["Option22", true]
	choice.set_text(option[0])
	if option[1]:
		choice.pressed = true
	else:
		choice.pressed = false

func _on_SaveButton_pressed():
	#TODO store choice
	#TODO if prev scene
	get_tree().change_scene("menus/EndLevelSettings.tscn")