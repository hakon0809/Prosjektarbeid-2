extends Node2D



func _on_EnterBoss_body_entered(body):
	if body.is_in_group("character"):
		print("wii")
		$Platforms/Restrict.set_position(Vector2(0,-150))
		#when you have beat the boss, use this to allow progress
		#$Platforms/Allow.set_position(Vector2(0,100))
		$Player/KinematicBody2D/Camera2D.limit_left = 80
		#change scene
		pass


func _on_NextArea_body_entered(body):
	if body.is_in_group("character"):
		print("wiiiii")
		#change scene
		pass
