extends Container

onready var popup = $MarginContainer/PanelContainer/Popup
onready var scene_1 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene1
onready var scene_2 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene2
onready var scene_3 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene3
onready var all_settings = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/AllSettings
onready var setting = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Setting

var choices = [true, true, true]
var current_setting

onready var toggle = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Setting/HBoxContainer/TextureButton

var activity = ""

var skull

func _ready():
	popup.hide()
	scene_2.hide()
	scene_3.hide()
	all_settings.hide()

func _on_ExitButton_pressed():
	activity += "| exit |"
	popup.scene = self
	popup.show()
	
func save_changes():
	Globals.set_upgrade(2, choices)
	Globals.set_activity(1, activity)
	skull.save_choice(choices[0])
	self.queue_free()

#SCENE1____________________________________________________________________
func _on_Scene1Button_pressed():
	activity += "| continue |"
	scene_1.hide()
	scene_2.show()

#SCENE2____________________________________________________________________
func _on_ManageButton_pressed():
	activity += "| manage |"
	scene_2.hide()
	all_settings.show()

func _on_AgreeButton_pressed():
	activity += "| agree |"
	#open android prompt
	#PLACEHOLDER
	scene_2.hide()
	scene_3.show()

#ALLSETTINGS____________________________________________________________
func _on_SaveButton_pressed():
	activity += "| save |"
	all_settings.hide()
	scene_3.show()

func _on_LinkButton_pressed():
	activity += "| edit1 |"
	all_settings.hide()
	current_setting = 0
	toggle.pressed = true
	toggle.disabled = true
	setting.set_text(1)
	setting.show()

func _on_LinkButton2_pressed():
	activity += "| edit2 |"
	all_settings.hide()
	current_setting = 1
	if choices[1]:
		toggle.pressed = true
	else:
		toggle.pressed = false
	setting.set_text(2)
	setting.show()

func _on_LinkButton3_pressed():
	activity += "| edit3 |"
	all_settings.hide()
	current_setting = 2
	if choices[2]:
		toggle.pressed = true
	else:
		toggle.pressed = false
	setting.set_text(3)
	setting.show()

#SCENE3__________________________________________________________________
func _on_ReturnButton_pressed():
	save_changes()
	self.queue_free()

#SETTING_________________________________________________________________
func _on_Button_pressed():
	if toggle.is_pressed():
		activity += "| toggle on |"
		choices[current_setting] = true
	else:
		activity += "| toggle off |"
		choices[current_setting] = false
	if toggle.disabled:
		toggle.disabled = false
	setting.hide()
	all_settings.show()