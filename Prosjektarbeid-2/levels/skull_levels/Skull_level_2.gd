extends Node2D

var level = 2

func _ready():
	$Player/KinematicBody2D/Camera2D.limit_left = 0
	$Player/KinematicBody2D/Camera2D.limit_right = 650
	$Player/KinematicBody2D/Camera2D.limit_bottom = 450
	$Player/KinematicBody2D/Camera2D.limit_top = -2
	$Skull.scale = Vector2(-1, 1)

func _on_Area2D_body_entered(body):
	if body.is_in_group("character") && $Skull.encountered:
		print("Dra meg baklengs gjennom spaken, Kronk")
		get_tree().change_scene("res://levels/fighting_level_3/fighting_level_3.tscn")
		Globals.play_song(Globals.city_song, -17)
