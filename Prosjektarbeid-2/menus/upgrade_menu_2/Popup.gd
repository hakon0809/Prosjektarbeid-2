extends MarginContainer

onready var text = $PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
onready var confirm = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ConfirmButton
onready var back = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/BackButton
var page = 1
var scene

func _ready():
	text.text = "Are you sure you want to refuse the upgrade?"
	confirm.text = "Yes"
	back.text = "No"
	
func _on_BackButton_pressed():
	self.hide()

func _on_ConfirmButton_pressed():
	if page == 1:
		page += 1
		text.text = "You likely will die without this upgrade"
		confirm.text = "I am fine with dying"
		back.text = "Take me back"
	elif page == 2:
		page += 1
		text.text = "Absolutely sure?"
		confirm.text = "Yes"
		back.text = "No"
	elif page == 3:
		#Go back to game
		pass
	else:
		scene.save_changes(false)
