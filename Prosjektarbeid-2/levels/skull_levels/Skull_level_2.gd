extends Node2D

func _ready():
	$Player/KinematicBody2D/Camera2D.limit_left = 0
	$Player/KinematicBody2D/Camera2D.limit_right = 1000
	$Skull.scale = Vector2(-1, 1)
	$Skull.level = 2