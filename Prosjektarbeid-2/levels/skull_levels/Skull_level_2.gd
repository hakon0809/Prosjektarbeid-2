extends Node2D

func _ready():
	$Player/KinematicBody2D/Camera2D.limit_left = 0
	$Player/KinematicBody2D/Camera2D.limit_right = 650
	$Player/KinematicBody2D/Camera2D.limit_bottom = 250
	$Skull.scale = Vector2(-1, 1)
	$Skull.level = 2

func _on_Area2D_body_entered(body):
	if body.is_in_group("character") && $Skull.encountered:
		print("Dra meg baklengs gjennom spaken, Kronk")