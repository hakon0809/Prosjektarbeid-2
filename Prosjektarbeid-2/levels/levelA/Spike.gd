extends Node

func _ready():
	print("fuck")

func _on_Area2D_body_entered(body):
	print("omgwtfbbq")
	if body.is_in_group("character"):
		body.take_damage(1)
