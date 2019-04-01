extends Area2D

var damage = 1

func _ready():
	pass

func _on_SpikeArea2D_body_entered(body):
	print("WTFBBQ")
	if body.is_in_group("character"):
		body.take_damage(damage)
