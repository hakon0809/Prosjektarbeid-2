extends Node2D

export var text = [
		"tekst1",
		"tekst2",
		"tekst3",
	]
var index = 0
var choice = null

func _ready():
	$PopupDialog/RichTextLabel.set_text(text[index])

func _on_Area2D_body_entered(body):
	if body.is_in_group("Character"):
		$PopupDialog.popup_centered_ratio(0.6)
	if choice != null:
		$PopupDialog/NextButton.hide()
		$PopupDialog/BackButton.hide()
	if index == 0:
		$PopupDialog/BackButton.set_disabled(true)

func _on_Area2D_body_exited(body):
	$PopupDialog.hide()

func _on_NextButton_pressed():
	if index == text.size() - 1:
		$PopupDialog/RichTextLabel.set_text("Wrong choice kiddo")
		$PopupDialog.hide()
		choice = true
	if index < text.size() - 1:
		index += 1
		if index == text.size() - 1:
			$PopupDialog/NextButton.text = "Accept"
			$PopupDialog/BackButton.text = "Decline"
		$PopupDialog/RichTextLabel.set_text(text[index])
		if index != 0:
			$PopupDialog/BackButton.set_disabled(false)

func _on_BackButton_pressed():
	if index == text.size() - 1:
		$PopupDialog/RichTextLabel.set_text("Wrong choice kiddo")
		$PopupDialog.hide()
		choice = false
	elif index > 0:
		index -= 1
		$PopupDialog/RichTextLabel.set_text(text[index])
		if index == 0:
			$PopupDialog/BackButton.set_disabled(true)
