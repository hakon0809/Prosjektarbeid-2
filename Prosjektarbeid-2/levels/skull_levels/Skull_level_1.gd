extends Node2D

onready var character = get_node("Player/KinematicBody2D")
onready var camera = get_node("Player/KinematicBody2D/Camera2D")

var visibility = 0

func _ready():
	$Skull.level = 1
	$Skull.hide()
	camera.limit_left = 0
	camera.limit_right = 1100
	



func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		if $Skull.encountered:
			get_tree().change_scene("res://levels/levelA/levelA.tscn")
		else:
			$Skull.position.y = 128
			$Skull.modulate = Color(0, 0, 0)
			$Skull.show()
