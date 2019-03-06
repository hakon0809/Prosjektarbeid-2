extends KinematicBody2D
const GRAVITY = 10
const SPEED = 80
const FLOOR =Vector2(0, -1)

var velocity =Vector2()

var direction = 1
var health = 1
var damage = 1


func _ready():
	pass

func _physics_process(delta):
	velocity.x = SPEED * direction
	
	if direction == 1:
		$AnimatedSprite.flip_h = false
	else:
		$AnimatedSprite.flip_h= true
	$AnimatedSprite.play("walk")
	
	velocity.y += GRAVITY
	
	velocity = move_and_slide(velocity, FLOOR)
	
	if is_on_wall():
		direction= direction * -1
		$RayCast2D.position.x *= -1
		
	if not $RayCast2D.is_colliding():
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
		set_physics_process(false)
		print ("npc dead")
		health = 0
	##	_change_state(DEAD)
#		emit_signal("died")
		return
		
		
		
	
		
		
	
	
	