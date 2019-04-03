extends Node2D


func _ready():
	$speech_bubble.hide()
	pass
	
	

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		$speech_bubble.show()
	pass
	


func _on_Area2D_body_exited(body):
	if body.is_in_group("character"):
		$speech_bubble.hide()
	pass