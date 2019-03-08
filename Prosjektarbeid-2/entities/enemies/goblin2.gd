extends KinematicBody2D

const GRAVITY = 10
const FLOOR =Vector2(0, -1)

const RIGTHBALL = preload("rigthball.tscn")
const LEFTBALL = preload("leftball.tscn")

var velocity =Vector2()
var direction = 1
var health = 1
var damage = 1
var speed = 80



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
	if speed == 0:
		speed = 80

	velocity.x = speed * direction

	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h= true
	
	if can_shoot && $AnimatedSprite.flip_h == false:
		$AnimatedSprite.play("shot")
		var rigthball = RIGTHBALL.instance()
		get_parent().add_child(rigthball)
		rigthball.position = $Position2D.global_position
		can_shoot=false
		timer.start()
		
	elif can_shoot && $AnimatedSprite.flip_h == true:
		$AnimatedSprite.play("shot")
		var leftball = LEFTBALL.instance()
		get_parent().add_child(leftball)
		leftball.position = $Position2D.global_position
		can_shoot=false
		timer.start()
		
	else:
		$AnimatedSprite.play("walk")

	velocity.y += GRAVITY

	velocity = move_and_slide(velocity, FLOOR)

	if is_on_wall():
		direction= direction * -1
		$RayCast2D.position.x *= -1

	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
	
	
	

	var bodies = $Area2D.get_overlapping_bodies()
		##print(bodies)

	for body in bodies:

		if body.is_in_group("character"):
			print(body)
			body.take_damage(damage)

func take_damage(count):
	health -= count
	if health < 0:
		$AnimatedSprite.play("die")
		print ("npc dead")
		health = 0
		queue_free()
	##	_change_state(DEAD)
#		emit_signal("died")
		return


