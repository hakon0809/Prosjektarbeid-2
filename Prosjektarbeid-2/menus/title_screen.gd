extends Control

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass


func _on_Continue_pressed():
	get_tree().change_scene('res://menus/Continue.tscn')


func _on_newgame_pressed():
	get_tree().change_scene('res://menus/NewGame.tscn')


func _on_Options_pressed():
	get_tree().change_scene('res://menus/Options.tscn')


