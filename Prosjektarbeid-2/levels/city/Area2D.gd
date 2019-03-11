extends Area2D

func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func _on_Area2D_body_entered(body):
	print("put on some gobber m8")
	#get_tree().change_scene("res://levels/.....")