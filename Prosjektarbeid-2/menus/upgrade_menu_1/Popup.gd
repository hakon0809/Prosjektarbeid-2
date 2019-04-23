extends MarginContainer

onready var text = $PanelContainer/MarginContainer/VBoxContainer/RichTextLabel
onready var confirm = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/ConfirmButton
onready var back = $PanelContainer/MarginContainer/VBoxContainer/HBoxContainer/BackButton
var page = 1
#var scene = 1
var scene

#func _ready():
#	if scene == 1:
#		text = "Welcome to the upgrade menu. Here you can exchange data for upgrades"
#	if scene == 2:
#		text = ""

func _on_BackButton_pressed():
	self.hide()

func _on_ConfirmButton_pressed():
	if page == 1:
		page += 1
		text.text = "You will likely die without this upgrade"
		back.text = "No"
		scene = 1
	elif page == 2:
		page += 1
		text.text = "Absolutely sure?"
		confirm.text = "Yes"
		back.text = "No"
		scene = 1
	else:
		scene.choices = [false, false, false]
		scene = 1
		scene.save_changes()