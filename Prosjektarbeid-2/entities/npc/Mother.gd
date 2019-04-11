extends Node2D

var player
var dialog_text
var button
var dialog
var interface

var dialogArrayHappy = [
	"Ah, hello son! We've missed you so much!",
	"Why are you back so early?",
	"Escaped? If so we need to get you over the border as fast as possible.",
	"First you should sleep, but there’s a secret tunnel at the end of the village that will take you a good way to the border.",
	"We’ll follow later, as soon as we can: things have taken a turn for the worse in this country lately."
	]
var dialogArrayMedium = [
	"Hello son, we heard you escaped.",
	"We’ve missed you.",
	"We understand that your escape must have been difficult, but we don’t appreciate being sold out to the skeletal man.",
	"Now you might have gotten us into trouble with the king as well.",
	"You can stay here tonight, but we can’t risk helping you any further.",
	"We’ll come looking for you as soon as we can, though: things have taken a turn for the worse lately..."
	]
var dialogArrayPissed = [
	"Hello son, we heard you escaped.",
	"Unfortunately you need to leave.",
	"When you sold our information to the skeletal figure, we got in trouble as well.",
	"We might come after you later, but if they find you here now it’ll only get worse for us."
	]
var dialogIndex
var currentDialogArray

func _ready():
	player = get_node("../../Player")
	dialog_text = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
	dialog = $PopupDialog/PopupDialog
	button = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/NextButton
	interface = get_node("../../Player/Interface/Control")
	
	dialog.hide()
	
	dialogIndex = 0
	
	#CONDITIONAL ON EARLER CHOICES
	currentDialogArray = dialogArrayHappy
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		dialog.show()
		interface.hide()
		if dialogIndex == 0:
			dialog_text.set_text(currentDialogArray[dialogIndex])
	


func _on_Area2D_body_exited(body):
	if body.is_in_group("character"):
		player.setDialogueSource(null)


func converse():
	pass

func _on_NextButton_pressed():
	dialogIndex += 1
	if dialogIndex >= currentDialogArray.size():
		dialog.hide()
		interface.show()
	else:
		dialog_text.set_text(currentDialogArray[dialogIndex])
