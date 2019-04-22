extends Node2D

var text = {
	1: [
		"Hello stranger, I have an offer for you. I am sure you will find it interesting.",
		"In exchange for a little information about you, I might be able to help you proceed.",
		"This life saving armour can be yours if you sign this contract...",
	],
	2: [
		"Hello again, friend. I have another interesting offer for you.",
		"In exchange for some information about your… acquaintances, I can offer you this excellent sword.",
		"Simply sign this contract…",
	],
	3: [
		"Ah, old friend. We meet again. I have yet another interesting offer for you.",
		"This time, I will need some more specific information about… you.",
		"In exchange, I have this excellent bow. Just sign this contract…",
	],
}

var index = 0

export var level = 0
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
			button.text = "Let's see"
		dialog_text.set_text(text[level][index])
			
func open_choice_menu():
	dialog.hide()
	interface.hide()
	var c
	if level == 1:
		c = load("res://menus/upgrade_menu_1/UpgradeMenu1.tscn").instance()
	elif level == 2:
		c = load("res://menus/upgrade_menu_2/UpgradeMenu2.tscn").instance()
	else:
		c = load("res://menus/upgrade_menu_3/UpgradeMenu3.tscn").instance()
	var node = get_tree().get_root()
	var cl = CanvasLayer.new()
	node.add_child(cl)
	cl.add_child(c)

func save_choice(active):
	button.hide()
	if active:
		dialog_text.set_text("Excellent.")
		emit_signal("health_changed", 15)
	else:
		dialog_text.set_text("Disapointing.")
	dialog.show()
	interface.show()
	encountered = true
	
