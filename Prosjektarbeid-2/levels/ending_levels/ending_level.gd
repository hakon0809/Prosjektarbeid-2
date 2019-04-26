extends Node2D

var dialog_text
var button
var dialog
var interface

func _ready():
	dialog_text = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/RichTextLabel
	dialog = $PopupDialog/PopupDialog
	button = $PopupDialog/PopupDialog/PanelContainer/MarginContainer/HBoxContainer/NextButton
	interface = $Player/Interface/Control
	
	interface.hide()
	dialog.show()
	dialog_text.set_text("Phew, I actually managed it!")

func _on_EndArea_body_entered(body):
	if body.is_in_group("character"):
		Globals.music_player.stop()
		if Globals.data_sharing_mode == "data":
			get_tree().change_scene('res://menus/questionnaire/PostQuestionnaire.tscn')
		else:
			get_tree().change_scene("res://menus/TitleScreen.tscn")


func _on_NextButton_pressed():
	dialog.hide()
	interface.show()
