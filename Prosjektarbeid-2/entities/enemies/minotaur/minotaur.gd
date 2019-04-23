extends KinematicBody2D


const GRAVITY = 10
const FLOOR = Vector2(0, -1)

export var max_speed = 100
export var knockback = 10
export var circle_attack_damage = 2
export var overhead_attack_damage = 3
export var touch_damage = 1
export var health = 10
var velocity = Vector2()
var direction = 1
var speed = max_speed
var knockdir = Vector2(1, 0)
var hitstun = 0
var can_move = true
var attack_is_over = false
var damage_immunity = false


var current_state = null
var previous_state = null
var next_state = null

enum STATES { IDLE, WALK, CIRCLE_ATTACK, OVERHEAD_ATTACK, HURT, DIE}


func _ready():
	# Called when the node is added to the scene for the first time.
	# Initialization here
	pass

func is_change_state_possible():
	
	
		if current_state == DIE:
			return false
		elif previous_state == DIE:
			return false
		elif next_state == DIE || next_state == HURT:
			return true	
		elif not can_move:
 			return false
		else:
			return true
			
			
func _change_state(new_state):
	previous_state = current_state
	next_state = new_state
	
	
	if is_change_state_possible():
		current_state = new_state
		
		
	
	match current_state:
		
		DIE:
			
			queue_free()
		
		IDLE:
			if $Sprite/AnimationPlayer.current_animation != "idle":
				$Sprite/AnimationPlayer.play("idle")
			velocity.x = speed * direction
			velocity.y += GRAVITY
			#move_and_slide(velocity, FLOOR)
		
		WALK:
			if $Sprite/AnimationPlayer.current_animation != "walk":
				$Sprite/AnimationPlayer.play("walk")
			velocity.x = speed * direction
			velocity.y += GRAVITY
			#move_and_slide(velocity, FLOOR)
		
		CIRCLE_ATTACK:
			can_move = false
			
			var bodies = $overhead.get_overlapping_bodies()
			for body in bodies:
			
				if body.is_in_group("character"):
					
					if $Sprite/AnimationPlayer.current_animation != "ground_circle_attack":
						$Sprite/AnimationPlayer.play("ground_circle_attack")
						
					if $Sprite/AnimationPlayer.current_animation_position > 0.3:
						
						body.take_damage(circle_attack_damage)
						print(circle_attack_damage)
						can_move = true
					
			if attack_is_over:
				can_move = true
		
		
		OVERHEAD_ATTACK:
			can_move = false
			
			var bodies = $overhead.get_overlapping_bodies()
			for body in bodies:
			
				if body.is_in_group("character"):
					
					if $Sprite/AnimationPlayer.current_animation != "oveahead_attack":
						$Sprite/AnimationPlayer.play("oveahead_attack")
						
					if $Sprite/AnimationPlayer.current_animation_position > 0.3:
						
						body.take_damage(overhead_attack_damage)
						print(overhead_attack_damage)
						can_move = true
					
			if attack_is_over:
				can_move = true
				
		HURT:
			damage_immunity = true
			can_move = false
			if $Sprite/AnimationPlayer.current_animation != "blink":
				$Sprite/AnimationPlayer.play("blink")
			self.modulate.a = 0.1
			if $Sprite/AnimationPlayer.current_animation_position > 0.8:
				self.modulate.a = 1
				can_move=true
				damage_immunity = false
			
			
		
		
		
func _physics_process(delta):
	
	
	movment()
	
	

	if direction == 1:
		
		$Sprite.flip_h = false
		$overhead.set_scale(Vector2(1, 1))
		$stab.set_scale(Vector2(1, 1))
		$circle_sweep.set_scale(Vector2(1, 1))
		$touch.set_scale(Vector2(1, 1))
	else:
		$Sprite.flip_h= true
		$overhead.set_scale(Vector2(-1, 1))
		$stab.set_scale(Vector2(-1, 1))
		$circle_sweep.set_scale(Vector2(-1, 1))
		$touch.set_scale(Vector2(-1, 1))
	
	
	
	
	if is_on_wall():
		direction= direction * -1
	#	$RayCast2D.position.x *= -1
		
	#if $RayCast2D.is_colliding() == false:
	#	direction = direction * -1
	#	$RayCast2D.position.x *= -1
func movment():
	
	if speed == 0 && hitstun == 0:
		
		_change_state(IDLE)
		
	elif hitstun == 0:
		_change_state(WALK)
	
	else:
		velocity.x = knockdir.x * knockback * direction
		hitstun -= 1
	move_and_slide(velocity, FLOOR)

func take_damage(count):
	if not damage_immunity: 
		health -= count
		
		print(health)
		if health <= 0:
			_change_state(DIE)
		else:
			_change_state(HURT)


func _on_overhead_body_entered(body):
	if body.is_in_group("character"):
		speed = 0
		_change_state(IDLE)
		_change_state(OVERHEAD_ATTACK)
		speed = max_speed 


func _on_circle_sweep_body_entered(body):
	if body.is_in_group("character"):
		speed = 0
		_change_state(IDLE)
		_change_state(CIRCLE_ATTACK)
		speed = max_speed 


func _on_touch_area_shape_entered(area_id, area, area_shape, self_shape):
	var bodies = $overhead.get_overlapping_bodies()
	for body in bodies:
	
		if body.is_in_group("character"):
			body.take_damage(touch_damage)
			print(touch_damage)
			can_move = true
			
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "oveahead_attack" || anim_name == "ground_circle_attack":
		attack_is_over = true 
	else:
		attack_is_over = false			