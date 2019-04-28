extends Container

onready var popup1 = $MarginContainer/PanelContainer/Popup1
onready var popup2 = $MarginContainer/PanelContainer/Popup2
onready var popup3 = $MarginContainer/PanelContainer/Popup3
onready var scene_1 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene1
onready var scene_2 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene2
onready var scene_3 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene3
onready var scene_4 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene4
onready var scene_5 = $MarginContainer/PanelContainer/VBoxContainer/ContentContainer/Scene5

#onready var Scene1Button = $PanelContainer/MarginContainer/VBoxContainer/ContentContainer/Scene1/Scene1Button
onready var Scene1Button = $Scene1Button

var choices = [true, true]
var skull

var activity = ""

func save_changes():
	skull.save_choice(choices[0])
	Globals.set_upgrade(1, choices)
	Globals.set_activity(0, activity)
	self.queue_free()

func _ready():
	Globals.upgrade_menu = self
	popup1.hide()
	popup2.hide()
	popup3.hide()
	scene_2.hide()
	scene_3.hide()
	scene_5.hide()
#	Scene1Button.text = "Get started"

func request_callback(request_code, permissions, granted):
	if scene_3.visible and granted:
		scene_3.hide()
		scene_5.show()
	else:
		Globals.permissions.requestReadPhoneStatePermission()

func _on_ExitButton_pressed():
	activity += "| exit |"
	popup1.scene = self
	popup1.show()
	
	
#SCENE1____________________________________________________________________
func _on_Scene1Button_pressed():
	scene_1.hide()
	scene_2.show()
	
#SCENE2____________________________________________________________________
func _on_Scene2Button_pressed():
	scene_2.hide()
	scene_3.show()
	
#SCENE3____________________________________________________________________
func _on_Scene3Button_pressed():
	activity += "| agree |"
	Globals.permissions.requestReadPhoneStatePermission()

func _on_Scene3Manage_pressed():
	activity += "| manage |"
	popup2.show()
	popup2.scene = self
	
func _on_Button_pressed():
	save_changes()
