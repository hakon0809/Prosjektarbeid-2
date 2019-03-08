extends Node2D

export var text = [
		"tekst1",
		"tekst2",
		"tekst3",
	]
var index = 0
var choice = null

func _ready():
	$PopupDialog/PopupDialog/RichTextLabel.set_text(text[index])

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		$PopupDialog/PopupDialog.popup_centered_ratio(0.5)
	if choice != null:
		$PopupDialog/PopupDialog/NextButton.hide()
		$PopupDialog/PopupDialog/BackButton.hide()
	if index == 0:
		$PopupDialog/PopupDialog/BackButton.set_disabled(true)

func _on_Area2D_body_exited(body):
	if body.is_in_group("character"):
		$PopupDialog/PopupDialog.hide()

func _on_NextButton_pressed():
	if index == text.size() - 1:
		$PopupDialog/PopupDialog/RichTextLabel.set_text("Wrong choice kiddo")
		$PopupDialog/PopupDialog.hide()
		choice = true
	if index < text.size() - 1:
		index += 1
		if index == text.size() - 1:
			$PopupDialog/PopupDialog/NextButton.text = "Accept"
			$PopupDialog/PopupDialog/BackButton.text = "Decline"
		$PopupDialog/PopupDialog/RichTextLabel.set_text(text[index])
		if index != 0:
			$PopupDialog/PopupDialog/BackButton.set_disabled(false)

func _on_BackButton_pressed():
	if index == text.size() - 1:
		$PopupDialog/PopupDialog/RichTextLabel.set_text("Wrong choice kiddo")
		$PopupDialog/PopupDialog.hide()
		choice = false
	elif index > 0:
		index -= 1
		$PopupDialog/PopupDialog/RichTextLabel.set_text(text[index])
		if index == 0:
			$PopupDialog/PopupDialog/BackButton.set_disabled(true)
