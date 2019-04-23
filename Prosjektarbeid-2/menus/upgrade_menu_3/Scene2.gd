extends VBoxContainer

func set_text(setting):
	if setting == 0:
		$RichTextLabel.text = "Access location"
	elif setting == 1:
		$RichTextLabel.text = "Access camera"
	else:
		$RichTextLabel.text = "Record audio"