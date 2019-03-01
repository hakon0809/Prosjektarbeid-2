extends Node

onready var phone = preload("res://menus/choices/Phone.tscn")

func _on_Button_pressed():
	var p = phone.instance()
	p.level = 1
	self.add_child(p)
	p.choice()
	p.end_level = false