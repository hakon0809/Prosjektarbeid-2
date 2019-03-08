extends Node2D

export var text = [
		"tekst1",
		"tekst2",
		"tekst3",
	]
var index = 0

var level
onready var ChoiceMenu = preload("res://menus/choices/ChoiceMenu.tscn")
var encountered = false
var interface


func _ready():
	$PopupDialog/PopupDialog/RichTextLabel.set_text(text[index])
	interface = get_tree().get_root().get_node("Node/Player/Interface/Control")
	
func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		if not encountered:
			$PopupDialog/PopupDialog.popup_centered_ratio(0.5)
			interface.hide()
			encountered = true
	if index == 0:
		$PopupDialog/PopupDialog/BackButton.set_disabled(true)

func _on_Area2D_body_exited(body):
	if body.is_in_group("character"):
		$PopupDialog/PopupDialog.hide()

func _on_NextButton_pressed():
	if index == text.size() - 1:
		open_choice_menu()
	if index < text.size() - 1:
		index += 1
		if index == text.size() - 1:
			$PopupDialog/PopupDialog/NextButton.text = "Hmm"
			$PopupDialog/PopupDialog/BackButton.hide()
		$PopupDialog/PopupDialog/RichTextLabel.set_text(text[index])
		if index != 0:
			$PopupDialog/PopupDialog/BackButton.set_disabled(false)

func _on_BackButton_pressed():
	if index > 0:
		index -= 1
		$PopupDialog/PopupDialog/RichTextLabel.set_text(text[index])
		if index == 0:
			$PopupDialog/PopupDialog/BackButton.set_disabled(true)
			
func open_choice_menu():
	$PopupDialog/PopupDialog.hide()

	interface.hide()
	var c = ChoiceMenu.instance()
	var node = get_tree().get_root()
	var cv = CanvasLayer.new()
	node.add_child(cv)
	cv.add_child(c)
	c.level = level
	c.end_level = false
	var choice = c.choice(self)
	

func save_choice(active):
	$PopupDialog/PopupDialog/NextButton.hide()
	$PopupDialog/PopupDialog/BackButton.hide()
	var upgrade = get_tree().get_root().get_node("Node/Player/KinematicBody2D").upgrades[level-1]
	if active:
		upgrade = true
		$PopupDialog/PopupDialog/RichTextLabel.set_text("Good job, go get em")
	else:
		$PopupDialog/PopupDialog/RichTextLabel.set_text("Wrong choice kiddo")
		upgrade = false
	$PopupDialog/PopupDialog.popup_centered_ratio(0.5)
	interface.show()
	
