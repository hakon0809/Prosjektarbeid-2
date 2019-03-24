extends KinematicBody2D

const GRAVITY = 10
const FLOOR =Vector2(0, -1)

var velocity = Vector2()
var direction = 1
var health = 3
var damage = 1
var speed = 80
var knockdir = Vector2(1, 0)
var canmove = true
var hitstun = 0



func _ready():
	pass

func _physics_process(delta):
	
	
	
	movment()
	
		
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
	canmove = false
	health -= count
	$AnimatedSprite.play("hurt")
	if health < 0:
		$AnimatedSprite.play("die")
		print ("npc dead")
		health = 0
		queue_free()
		return
		
func movment():
	
	if hitstun == 0:
		velocity.x = speed * direction
		velocity.y += GRAVITY
		canmove = true
			
	else:
		velocity.x = knockdir.x * 10 * direction
		print(velocity.x)
		hitstun -= 1
		print(hitstun)
	move_and_slide(velocity, FLOOR)

		
		
		
		
	

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
