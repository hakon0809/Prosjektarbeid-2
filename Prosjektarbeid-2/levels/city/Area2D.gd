extends Area2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		print("put on some gobber m8")
		#Globals.play_song() *insert song, optionally volume in db*
		get_tree().change_scene("res://levels/skull_levels/Skull_level_3.tscn")
		Globals.play_song(Globals.main_menu_song)