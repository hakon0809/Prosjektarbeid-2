extends "res://entities/enemies/enemy.gd"

const RIGTHBALL = preload("rigthball.tscn")
const LEFTBALL = preload("leftball.tscn")


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
	
	
	if can_shoot && $AnimatedSprite.flip_h == false:
		speed = 0 * delta
		$AnimatedSprite.play("shot")
		var rigthball = RIGTHBALL.instance()
		get_parent().add_child(rigthball)
		rigthball.position = $Position2D.global_position
		
		can_shoot=false
		timer.start()
		
	elif can_shoot && $AnimatedSprite.flip_h == true:
		speed = 0 * delta
		$AnimatedSprite.play("shot")
		var leftball = LEFTBALL.instance()
		get_parent().add_child(leftball)
		leftball.position = $Position2D.global_position
		can_shoot=false
		timer.start()
		
	