extends Node

onready var phone = preload("res://menus/choices/Phone.tscn")

func _on_Button_pressed():
	var p = phone.instance()
	self.add_child(p)