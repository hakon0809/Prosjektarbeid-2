extends Node2D




func _ready():
	Globals.play_song(Globals.boss_song)
func _on_EnterBoss_body_entered(body):
	if body.is_in_group("character"):
		print("wii")
		$Platforms/Restrict.set_position(Vector2(0,-150))
		#when you have beat the boss, use this to allow progress
		#$Platforms/Allow.set_position(Vector2(0,100))
		$Player/KinematicBody2D/Camera2D.limit_left = 80


func _on_NextArea_body_entered(body):
	if body.is_in_group("character"):
		get_tree().change_scene("res://levels/ending_levels/ending_level.tscn")
