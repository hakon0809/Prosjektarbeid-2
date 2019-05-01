extends VBoxContainer

func set_text(setting):
	if setting == 0:
		$Label.text = "Access location"
		$RichTextLabel.text = "Allows the application to access the device's location"
	elif setting == 1:
		$Label.text = "Access camera"
		$RichTextLabel.text = "Allows the application access to the camera"
	else:
		$Label.text = "Record audio"
		$RichTextLabel.text = "Gives the application access to record audio"