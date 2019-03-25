extends Node2D

export var text = [
		"tekst1",
		"tekst2",
		"tekst3",
	]
var index = 0

export var level = 0
onready var ChoiceMenu = preload("res://menus/choices/ChoiceMenu.tscn")
var encountered = false
var interface

onready var dialog_text = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
onready var button = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/NextButton
onready var dialog = $PopupDialog/PopupDialog

func _ready():
	dialog_text.set_text(text[index])
	interface = get_tree().get_root().get_node("Node/Player/Interface/Control")
	dialog.hide()
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		if not encountered:
			dialog.show()
			interface.hide()
			encountered = true

func _on_Area2D_body_exited(body):
	if body.is_in_group("character"):
		dialog.hide()

func _on_NextButton_pressed():
	if index == text.size() - 1:
		open_choice_menu()
	if index < text.size() - 1:
		index += 1
		if index == text.size() - 1:
			button.text = "Lemme see"
		dialog_text.set_text(text[index])
			
func open_choice_menu():
	dialog.hide()
	interface.hide()
	var c = ChoiceMenu.instance()
	var node = get_tree().get_root()
	var cl = CanvasLayer.new()
	node.add_child(cl)
	cl.add_child(c)
	c.level = level
	c.end_level = false
	c.open_choice_menu(self)
	

func save_choice(active):
	button.hide()
	if active:
		dialog_text.set_text("Good job, go get em")
	else:
		dialog_text.set_text("Wrong choice kiddo")
	dialog.show()
	interface.show()
	get_tree().change_scene("res://levels/levelA/levelA.tscn")
	
