extends Node


func _ready():
	pass

func _on_ManageButton_pressed():
	get_tree().change_scene("menus/PrivacyInfo.tscn")
