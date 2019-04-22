extends Node2D

var max_depth = 1200

func _ready():
	$Player/KinematicBody2D/Camera2D.limit_left = -80
	$Player/KinematicBody2D/Camera2D.limit_right = 2200
	var status = Globals.get_upgrade(3)
	if status[1] or status[2]:
		$Player/KinematicBody2D.health -= 4
	elif status[0]:
		$Player/KinematicBody2D.health -= 2


func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		#Change scene