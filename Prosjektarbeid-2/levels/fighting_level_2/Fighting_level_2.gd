extends Node

var max_depth = 2000
var tunnel = false

func _ready():
	var status = Globals.get_upgrade(3)
	if not status[0]:
		tunnel = true
		$Player.position += Vector2(100, 310)
	elif status[1] or status[2]:
		$Player/KinematicBody2D.health -= 4

func _process(delta):
	if tunnel:
		if $Player/KinematicBody2D.position.x > 1900:
			$Player/KinematicBody2D/Camera2D.limit_bottom = 810
		else:
			$Player/KinematicBody2D/Camera2D.limit_bottom = 920

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		print("wiiiii")
		#change scene
		pass
