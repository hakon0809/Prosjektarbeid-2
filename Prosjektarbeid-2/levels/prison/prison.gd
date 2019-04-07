extends Node2D

var dialog_text
var button
var dialog
var interface

var dialogArray = [
	"The prison wall exploded?",
	"Maybe I can escape and get over the border",
	"If I can get to the city my parents may be able to help me"
	]
var dialogIndex = 0


func _ready():
	dialog_text = $IntroText/PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
	dialog = $IntroText/PopupDialog/PopupDialog
	button = $IntroText/PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/NextButton
	interface = $Player/Interface/Control
	
	dialog.hide()
	interface.hide()
	button.text = "Next"

func _on_ExplosionEnd_timeout():
	dialog.show()
	dialog_text.set_text(dialogArray[dialogIndex])


func _on_NextButton_pressed():
	dialogIndex += 1
	if dialogIndex >= dialogArray.size():
		dialog.hide()
		interface.show()
	else:
		dialog_text.set_text(dialogArray[dialogIndex])
