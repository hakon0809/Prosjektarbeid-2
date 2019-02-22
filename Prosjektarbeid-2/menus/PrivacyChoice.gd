extends Node


func _ready():
	#TODO set text
	pass

func _on_ManageButton_pressed():
	get_tree().change_scene("menus/PrivacyInfo.tscn")


func _on_AcceptButton_pressed():
	get_tree().quit()
