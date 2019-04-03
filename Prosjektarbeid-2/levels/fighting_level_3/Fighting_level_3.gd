extends Node2D

var max_depth = 1200

func _ready():
	$Player/KinematicBody2D/Camera2D.limit_right = 2200