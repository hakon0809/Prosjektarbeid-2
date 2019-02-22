extends Node

func _ready():
	#TODO set text
	pass

func _on_ContinueButton_pressed():
	get_tree().change_scene("menus/PrivacySettings.tscn")
