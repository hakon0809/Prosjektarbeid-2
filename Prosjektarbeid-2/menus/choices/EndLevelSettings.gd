extends Node

var option1 = ["Option1", true] #=MainChar upgrade1
var option2 = ["Option2", false] #=MainChar upgrade2
var option3 = ["Option3", true] #=MainChar upgrade3
var options = [option1, option2, option3]
var level = 3 #=MainChar level
onready var options_container = get_node(
		"PanelContainer/VBoxContainer/HBoxContainer/VBoxContainer/InfoContainer/ScrollContainer/VBoxContainer")
	
func _ready():
	var i = 0
	for option in options:
		if i == level:
			break
		add_option(option, i)
		i += 1
		
func add_option(option, i):
		var option_container = VBoxContainer.new()
		option_container.set_name("VBoxContainer")
		options_container.add_child(option_container)
		var label = Label.new()
		label.set_name(option[0]+"Label")
		label.set_text(option[0])
		label.add_font_override("font", load("ui/segoe.tres"))
		var status_label = Label.new()
		status_label.set_name("StatusLabel")
		status_label.add_font_override("font", load("ui/segoe.tres"))
		if option[1]:
			status_label.set_text("(Currently activated)")
		else:
			status_label.set_text("(Currently deactivated)")
		var button = LinkButton.new()
		button.set_name(option[0]+"Button")
		button.set_text("Edit")
		#TODO button.connect("pressed", self, button.get_name()+"_pressed")
		button.connect("pressed", self, "pressed") #Placeholder
		option_container.add_child(label)
		var margin_container = MarginContainer.new()
		margin_container.set_name("MarginContainer")
		option_container.add_child(margin_container)
		var edit_container = HBoxContainer.new()
		edit_container.set_name("HBoxContainer")
		margin_container.add_child(edit_container)
		edit_container.add_child(button)
		edit_container.add_child(status_label)


func Option1Button_pressed():
	#TODO var node = get_node("root/PrivacySettings").option = option1
	get_tree().change_scene("menus/PrivacySettings.tscn")
	
func pressed(): #PLACEHOLDER
	get_tree().change_scene("menus/PrivacySettings.tscn")
	
func _on_ContinueButton_pressed():
	get_tree().quit()
	
