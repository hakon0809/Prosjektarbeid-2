extends "res://entities/enemies/enemy.gd"

const ARROW = preload("arrow.tscn")


var timer = null
var can_shoot = true



func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(2)
	timer.connect("timeout", self, "on_timeout")
	add_child(timer)

func on_timeout():
	can_shoot=true
	
	

func _physics_process(delta):
	
	
	if can_shoot:
		
		$AnimatedSprite.play("shot")
		var arrow = ARROW.instance()
		get_parent().add_child(arrow)
		if $AnimatedSprite.flip_h == false:
			arrow.position = $Position2D.global_position
		else:
			
			arrow.speed= -arrow.speed
			arrow.position = $Position2D.global_position
		
		can_shoot=false
		timer.start()
		
		
		

	