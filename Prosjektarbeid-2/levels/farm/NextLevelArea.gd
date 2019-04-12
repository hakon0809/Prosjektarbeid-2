extends Area2D

# class member variables go here, for example:
# var a = 2
# var b = "textvar"

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

#func _process(delta):
#	# Called every frame. Delta is time since last frame.
#	# Update game logic here.
#	pass


func _on_NextLevelArea_body_entered(body):
	if body.is_in_group("character"):
		print("put on some gobber m8")
		#Globals.play_song() *insert song, optionally volume in db*
		get_tree().change_scene("res://levels/skull_levels/Skull_level_2.tscn")
		Globals.play_song(Globals.main_menu_song)