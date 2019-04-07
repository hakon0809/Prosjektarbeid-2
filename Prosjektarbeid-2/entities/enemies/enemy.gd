extends KinematicBody2D

const GRAVITY = 10
const FLOOR = Vector2(0, -1)

export var max_speed = 80
export var knockback = 4
export var damage = 1
export var health = 2
var velocity = Vector2()
var direction = 1
var speed = max_speed
var knockdir = Vector2(1, 0)
var hitstun = 0
var can_move = true
var attack_is_over = true


var current_state = null
var previous_state = null
var next_state = null

enum STATES { IDLE, WALK, ATTACK, HURT, SHOT, DIE}

func _ready():
	
	pass
	
func is_change_state_possible():
	
		if current_state == DIE:
			return false
		elif previous_state == DIE:
			return false
		elif not can_move:
			return false
		elif not attack_is_over:
			return false
		else:
			return true
			
			
func _change_state(new_state):
	previous_state = current_state
	next_state = new_state
	
	
	if is_change_state_possible():
		current_state = new_state
	
	match current_state:
		
		IDLE:
			$AnimatedSprite.play("idle")
			velocity.x = speed * direction
			velocity.y += GRAVITY
			
		WALK:
		
			$AnimatedSprite.play("walk")
			velocity.x = speed * direction
			velocity.y += GRAVITY
			
		
		ATTACK:
			
			
			
			can_move = false
			
			var bodies = $Area2D.get_overlapping_bodies()
			for body in bodies:
			
				if body.is_in_group("character"):
					
					$AnimatedSprite.play("attack")
					
					if $AnimatedSprite.get_frame() >0:
						body.take_damage(damage)
						
						can_move = true
						print(damage)
			if $AnimatedSprite.get_frame() == 2:
	
				can_move = true
				
						
		HURT:
			can_move = false
			$AnimatedSprite.play("hurt")
			self.modulate.a = 0.2
			if $AnimatedSprite.get_frame() == 1:
				self.modulate.a = 1
				can_move=true
				print("test hurt")
				
		SHOT:
			can_move = false
			
			$AnimatedSprite.play("shot")
			
			
			if $AnimatedSprite.get_frame()	== 2:
				can_move = true
				
			
		
		DIE:
			can_move = false
			$AnimatedSprite.play("die")
			speed = 0
			if $AnimatedSprite.get_frame() == 4:
				queue_free()
			
		
	

func _physics_process(delta):
	
	
	movment()
	
	
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
	if health <= 0:
		_change_state(DIE)
	else:
		_change_state(HURT)	
func movment():
	
	if speed == 0 && hitstun == 0:
		
		_change_state(IDLE)
		
	elif hitstun == 0:
		_change_state(WALK)
	
	else:
		velocity.x = knockdir.x * knockback * direction
		hitstun -= 1
	move_and_slide(velocity, FLOOR)

func _on_Area2D_body_entered(body):
	if body.is_in_group("character"):
		speed = 0
		_change_state(IDLE)
		_change_state(ATTACK)
		speed = max_speed 
		
	


