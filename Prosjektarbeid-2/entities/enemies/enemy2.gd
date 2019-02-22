extends KinematicBody2D

const GRAVITY = 10
const SPEED = 80
const FLOOR =Vector2(0, -1)
const RIGTHBALL = preload("rigthball.tscn")
const LEFTBALL = preload("leftball.tscn")

var velocity =Vector2()

var direction = 1

var timer = null
var can_shoot = true



func _ready():
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(1)
	timer.connect("timeout", self, "on_timeout")
	add_child(timer)

func on_timeout():
	can_shoot=true
	
	

func _physics_process(delta):
	velocity.x = SPEED * direction
	
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h= true
	$AnimatedSprite.play("walk")
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)
	
	if can_shoot && $AnimatedSprite.flip_h == false:
		var rigthball = RIGTHBALL.instance()
		get_parent().add_child(rigthball)
		rigthball.position = $Position2D.global_position
		can_shoot=false
		timer.start()
		
	elif can_shoot && $AnimatedSprite.flip_h == true:
		var leftball = LEFTBALL.instance()
		get_parent().add_child(leftball)
		leftball.position = $Position2D.global_position
		can_shoot=false
		timer.start()
		
	
	if is_on_wall():
		direction= direction * -1
		$RayCast2D.position.x *= -1
		
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
		



