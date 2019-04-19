extends Node2D

var player
var dialog_text
var button
var dialog
var interface

var dialogArray = [
	"Hei, kjære spiller :-)",
	"Her kan du slappe av og restituere en liten stund før du skal kjempe videre..",
	"Lykke til! :-)"
	]
var dialogIndex

func _ready():
	player = get_node("../Player")
	dialog_text = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
	dialog = $PopupDialog/PopupDialog
	button = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/NextButton
	interface = get_node("../Player/Interface/Control")
	
	dialog.hide()
	print("test hide dialogboks")
	
	dialogIndex = 0

func _on_Area2D_body_entered(body):
	if body.is_in_group("character") && dialogIndex < dialogArray.size():
		player.setDialogueSource(self.get_path())
		print("body_entered")


func _on_Area2D_body_exited(body):
	if body.is_in_group("character"):
		player.setDialogueSource(null)
		print("body_exited")

func converse():
	print("converse")
	dialog.show()
	interface.hide()
	if dialogIndex >= dialogArray.size():
		dialog_text.set_text("Get out of my face, scum.")
	else:
		dialog_text.set_text(dialogArray[dialogIndex])

func _on_NextButton_pressed():
	print("_on_NextButton_pressed2")
	dialogIndex += 1
	print("_on_NextButton_pressed")
	if dialogIndex >= dialogArray.size():
		dialog.hide()
		interface.show()
		print("_on_NextButton_pressed2")
	else:
		dialog_text.set_text(dialogArray[dialogIndex])
		print("ikke _on_NextButton_pressed")