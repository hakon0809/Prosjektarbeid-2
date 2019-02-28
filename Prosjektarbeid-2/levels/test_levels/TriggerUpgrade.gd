extends Node

onready var PrivacyChoice = preload("res://menus/choices/PrivacyChoice.tscn")
onready var PrivacyInfo = preload("res://menus/choices/PrivacyInfo.tscn")
onready var PrivacySetting = preload("res://menus/choices/PrivacySettings.tscn")

func _on_Button_pressed():
	var choice = PrivacyChoice.instance()
	choice.level = 1
	choice.parent = self
	self.add_child(choice)

func change_setting():
	var info = PrivacyInfo.instance()
	info.level = 1
	info.parent = self
	self.add_child(info)
	
func show_setting():
	var setting = PrivacySetting.instance()
	setting.level = 1
	setting.parent = self
	setting.active = true
	self.add_child(setting)
	
func save_setting(active):
	pass