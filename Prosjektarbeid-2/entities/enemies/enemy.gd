extends KinematicBody2D

const GRAVITY = 10
const FLOOR =Vector2(0, -1)

var velocity = Vector2()
var direction = 1
var health = 10
var damage = 1
var speed = 80
var knockback = 2000
var canmove = true



func _ready():
	pass

func _physics_process(delta):

	
	velocity.x = speed * direction
	velocity.y += GRAVITY
	velocity = move_and_slide(velocity, FLOOR)
	
	if canmove:
		$AnimatedSprite.play("walk")
	
	
	if direction == 1:
		$AnimatedSprite.flip_h = false
		$Area2D.set_scale(Vector2(1, 1))
	else:
		$AnimatedSprite.flip_h= true
		$Area2D.set_scale(Vector2(-1, 1))
	
	
	
	
	if is_on_wall():
		direction= direction * -1
		$RayCast2D.position.x *= -1
		
	if $RayCast2D.is_colliding() == false:
		direction = direction * -1
		$RayCast2D.position.x *= -1
	

	
		
func take_damage(count): 
	health -= count
	if direction == 1:
		velocity.x = - knockback
		move_and_slide(velocity, FLOOR)
	else:
		velocity.x = knockback
		move_and_slide(velocity, FLOOR)
	print("enemy hit")
	if health < 0:
		$AnimatedSprite.play("die")
		print ("npc dead")
		health = 0
		queue_free()
	##	_change_state(DEAD)
#		emit_signal("died")
		return
		
	
	

func _on_Area2D_body_entered(body):
	canmove = false
	
	var bodies = $Area2D.get_overlapping_bodies()
	
	for body in bodies:
	
		if body.is_in_group("character"):
			$AnimatedSprite.play("attack")
			body.take_damage(damage)
	
	

func _on_Area2D_body_exited(body):
	if body.is_in_group("character"):
		canmove = true
