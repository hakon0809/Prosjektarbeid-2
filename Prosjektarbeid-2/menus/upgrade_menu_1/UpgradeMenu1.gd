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

var choices = [true, true, true]


func _ready():
	popup1.hide()
	popup2.hide()
	popup3.hide()
	scene_2.hide()
	scene_3.hide()
	scene_4.hide()
	scene_5.hide()
#	Scene1Button.text = "Get started"

func _on_ExitButton_pressed():
	popup1.scene = self
	popup1.show()
	
	
#SCENE1____________________________________________________________________
func _on_Scene1Button_pressed():
	scene_1.hide()
	scene_2.show()
	print("skrivesButton1")
	
#SCENE2____________________________________________________________________
func _on_Scene2Button_pressed():
	scene_2.hide()
	scene_3.show()
	
#SCENE3____________________________________________________________________
func _on_Scene3Button_pressed():
	scene_3.hide()
	scene_4.show()

func _on_Scene3Back_pressed():
	scene_2.show()
	scene_3.hide()

func _on_Scene3Manage_pressed():
	popup2.show()
	
func _on_Scene4Button_pressed():
	scene_3.hide()
	scene_5.show()	

func _on_Agreed_pressed():
	pass # replace with function body
