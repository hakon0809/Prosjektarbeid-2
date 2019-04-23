extends VBoxContainer

func set_text(setting, active):
	if setting == 0:
		$HBoxContainer/RichTextLabel.text = "Access location (this is required)"
		$HBoxContainer/TextureButton.disabled = true
	elif setting == 1:
		$HBoxContainer/RichTextLabel.text = "Access camera"
		$HBoxContainer/TextureButton.disabled = false
		$HBoxContainer/TextureButton.pressed = active
	else:
		$HBoxContainer/RichTextLabel.text = "Access audio recorder"
		$HBoxContainer/TextureButton.disabled = false
		$HBoxContainer/TextureButton.pressed = active