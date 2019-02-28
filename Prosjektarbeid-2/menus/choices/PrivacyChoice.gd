extends Node

onready var content = preload("res://menus/choices/MenuText.gd")
onready var header = $PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/InfoContainer/CenterContainer/Header
onready var text = $PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/InfoContainer/ChoiceText
var level
var parent
#onready var player

func _ready():
	header.set_text(content.CHOICE[level-1][0])
	text.set_text(content.CHOICE[level-1][1])

func _on_ManageButton_pressed():
	self.queue_free()
	parent.change_setting()

func _on_AcceptButton_pressed():
	self.queue_free()
	parent.save_setting(true)
