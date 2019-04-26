extends KinematicBody2D

const GRAVITY = 10
const FLOOR = Vector2(0, -1)

export var max_speed = 100
export var knockback = 50
export var circle_attack_damage = 2
export var overhead_attack_damage = 3
export var touch_damage = 1
export var health = 10
var velocity = Vector2()
var direction = 1
var speed = 0
var knockdir = Vector2(1, 0)
var hitstun = 0
var can_move = true
var attack_is_over = false
var damage_immunity = false
var overhead = "overhead"
var circle_sweep = "circle_sweep"


var current_state = null
var previous_state = null
var next_state = null

const IDLE = 0
const WALK = 1
const CIRCLE_ATTACK = 2
const OVERHEAD_ATTACK = 3
const HURT = 4
const DIE = 5
const TAUNT = 6

enum STATES { IDLE, WALK, CIRCLE_ATTACK, OVERHEAD_ATTACK, HURT, DIE, TAUNT}


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
			damage_immunity = true
			if $Sprite/AnimationPlayer.current_animation != "die":
				$Sprite/AnimationPlayer.play("die")
			if $Sprite/AnimationPlayer.current_animation_position > 0.8:
				get_tree().get_current_scene().get_child(1).get_child(7).set_position(Vector2(0,100))
				
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
			
			attack(circle_attack_damage, "ground_circle_attack", circle_sweep)
			
		
		
		OVERHEAD_ATTACK:
			
			attack(overhead_attack_damage, "oveahead_attack", overhead)
			
				
		HURT:
			damage_immunity = true
			can_move = false
			if $Sprite/AnimationPlayer.current_animation != "blink":
				$Sprite/AnimationPlayer.play("blink")
			self.modulate.a = 0.4
			if $Sprite/AnimationPlayer.current_animation_position > 0.5:
				self.modulate.a = 1
				can_move=true
				damage_immunity = false
			
		TAUNT:
			can_move = false
			if $Sprite/AnimationPlayer.current_animation != "taunt":
				$Sprite/AnimationPlayer.play("taunt")
			if $Sprite/AnimationPlayer.current_animation_position > 0.3:
				can_move = true	
		
		
		
#warning-ignore:unused_argument
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
	
func movment():
	
	if speed == 0 && hitstun == 0:
		
		_change_state(IDLE)
		
	elif hitstun == 0:
		_change_state(WALK)
	
	else:
		velocity.x = knockdir.x * knockback * direction
		hitstun -= 1
	move_and_slide(velocity, FLOOR)
	
	
func attack(attack_damage, attack_anim, areaname):
	can_move = false
	
	var bodies = null
	
	if areaname == "overhead":		
		bodies = $overhead.get_overlapping_bodies()
	else:
		bodies = $circle_sweep.get_overlapping_bodies()	
	
	for body in bodies:
			
		if body.is_in_group("character"):
					
			if $Sprite/AnimationPlayer.current_animation != attack_anim:
					$Sprite/AnimationPlayer.play(attack_anim)
						
			if $Sprite/AnimationPlayer.current_animation_position > 0.3:
						
				body.take_damage(attack_damage)
				can_move = true
					
		if $Sprite/AnimationPlayer.current_animation_position > 0.8:
			can_move = true
			attack_delay()
			
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
			
			
func _on_AnimationPlayer_animation_finished(anim_name):
	if anim_name == "oveahead_attack" || anim_name == "ground_circle_attack":
		attack_is_over = true 
	else:
		attack_is_over = false			

func _on_touch_body_entered(body):
	
	if body.is_in_group("character"):
		body.take_damage(touch_damage)
		speed = 0
		_change_state(IDLE)
		_change_state(TAUNT)
		speed = max_speed
		
func attack_delay():
	_change_state(TAUNT)	

func _on_VisibilityNotifier2D_screen_entered():
	speed = max_speed
