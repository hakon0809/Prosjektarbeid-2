extends Node2D

var text = {
	1: [
		"Welcome to my first world, kiddo.",
		"Here you will have to make a choice.",
		"Do you want this piece of armor, or take your chances?",
	],
	2: [
		"Welcome to my second world, kiddo.",
		"Here you will have to make a choice.",
		"Do you want this shiny new sword, or take your chances?",
	],
	3: [
		"Welcome to my third world, kiddo.",
		"Here you will have to make a choice.",
		"Do you want this new bow, or take your chances?",
	],
}

var index = 0

export var level = 0
onready var ChoiceMenu = preload("res://menus/choices/ChoiceMenu.tscn")
var encountered = false
var interface

onready var dialog_text = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
onready var button = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/NextButton
onready var dialog = $PopupDialog/PopupDialog

func _ready():
	level = get_parent().level
	dialog_text.set_text(text[level][index])
	interface = $"../Player/Interface/Control"
	dialog.hide()
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		if not encountered:
			modulate = Color(1, 1, 1)
			dialog.show()
			interface.hide()

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
		dialog_text.set_text(text[level][index])
			
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
		emit_signal("health_changed", 15)
	else:
		dialog_text.set_text("Wrong choice kiddo")
	dialog.show()
	interface.show()
	encountered = true
	
