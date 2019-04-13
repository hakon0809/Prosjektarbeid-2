extends Container

onready var popup = $MarginContainer/PanelContainer/Popup
onready var scene1 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene1
onready var scene2 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene2
onready var scene3 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene3
onready var scene4 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene4
onready var scene5 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene5

var choices = [true, true, true]
var current_setting = 0

var activity = ""

onready var toggle = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Setting/HBoxContainer/TextureButton

func _ready():
	popup.hide()
	scene2.hide()
	scene3.hide()
	scene4.hide()
	scene5.hide()

func _on_ExitButton_pressed():
	activity += "| exit |"
	popup.scene = self
	popup.show()
	
func save_changes():
	Globals.set_upgrade(3, choices)
	Globals.set_activity(2, activity)
	self.queue_free()

func _on_Scene1Continue_pressed():
	activity += "| continue |"
	scene1.hide()
	scene2.set_text(current_setting)
	scene2.show()

func _on_AgreeButton_pressed():
	activity += "| agree |"
	if current_setting < 2:
		current_setting += 1
		scene2.set_text(current_setting)
	else:
		scene2.hide()
		#android popup
		scene5.show()

func _on_InfoButton_pressed():
	activity += "| more info |"
	scene2.hide()
	scene3.set_text(current_setting)
	scene3.show()

func _on_BackButton_pressed():
	activity += "| back |"
	scene3.hide()
	scene2.show()


func _on_ManageButton_pressed():
	activity += "| manage |"
	scene3.hide()
	scene4.set_text(current_setting, choices[current_setting])
	scene4.show()


func _on_SaveButton_pressed():
	activity += "| save |"
	if $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene4/HBoxContainer/TextureButton.pressed:
		choices[current_setting] = true
	else:
		choices[current_setting] = false
	if current_setting < 2:
		current_setting += 1
		scene2.set_text(current_setting)
		scene4.hide()
		scene2.show()
	else:
		scene4.hide()
		#android popup
		scene5.show()
	


func _on_FinishButton_pressed():
	save_changes()
	self.queue_free()