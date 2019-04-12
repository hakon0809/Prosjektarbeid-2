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

func _ready():
	popup.hide()
	scene_2.hide()
	scene_3.hide()
	all_settings.hide()

func _on_ExitButton_pressed():
	popup.scene = self
	popup.show()
	
func save_changes():
	Globals.set_upgrade(2, choices)
	self.queue_free()

#SCENE1____________________________________________________________________
func _on_Scene1Button_pressed():
	scene_1.hide()
	scene_2.show()

#SCENE2____________________________________________________________________
func _on_ManageButton_pressed():
	scene_2.hide()
	all_settings.show()

func _on_AgreeButton_pressed():
	#open android prompt
	#PLACEHOLDER
	scene_2.hide()
	scene_3.show()

#ALLSETTINGS____________________________________________________________
func _on_SaveButton_pressed():
	all_settings.hide()
	scene_3.show()

func _on_LinkButton_pressed():
	all_settings.hide()
	current_setting = 0
	toggle.pressed = true
	toggle.disabled = true
	setting.set_text(1)
	setting.show()

func _on_LinkButton2_pressed():
	all_settings.hide()
	current_setting = 1
	if choices[1]:
		toggle.pressed = true
	else:
		toggle.pressed = false
	setting.set_text(2)
	setting.show()

func _on_LinkButton3_pressed():
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
		choices[current_setting] = true
	else:
		choices[current_setting] = false
	if toggle.disabled:
		toggle.disabled = false
	setting.hide()
	all_settings.show()