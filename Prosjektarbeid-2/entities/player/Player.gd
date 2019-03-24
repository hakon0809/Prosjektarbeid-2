extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -500
var motion = Vector2()
var friction = false

var sword_sound = load("res://entities/player/sounds/sword-gesture1.ogg")
var jump_sound = load("res://entities/player/sounds/jump.wav")
onready var sound_player = $"../AudioStreamPlayer"


#Different possible states, have not implemented STAGGER
enum STATES { IDLE, RUNLEFT, RUNRIGHT, JUMP, ATTACK, HURT, DIE, STAGGER}

signal health_changed
signal died

var current_state = null
var previous_state = null
var next_state = null

#var to check if attack is over
var attack_is_over = true

export var max_health = 10
var health

var damage = 1

var max_depth = null

func _ready():
	health = max_health
	if get_tree().get_current_scene().get("max_depth"):
		max_depth = get_tree().get_current_scene().get("max_depth")
	current_state = JUMP
	emit_signal("health_changed", health)
	
func play_sound(sound):
	sound_player.stream = sound
	sound_player.play()

#returns true if state change is possible 
func is_change_state_possible():
	
		if current_state == DIE:
			return false
		elif previous_state == DIE:
			return false
		elif attack_is_over == false:
			return false
			
		#Air attack doesnt work as intended yet TODO
		elif not is_on_floor() && next_state == ATTACK:
			return true
			
		elif not is_on_floor():
			return false
		else:
			return true
		
#Changes player state
func _change_state(new_state):
	previous_state = current_state
	next_state = new_state
	
	if is_change_state_possible():
		current_state = new_state

	
	match current_state:
		IDLE:
			$Sprite.play("Idle")
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)
		
		RUNLEFT:
				
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$Area2D.set_scale(Vector2(-1, 1))
			$Sprite.play("Run")
		
		RUNRIGHT:
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$Area2D.set_scale(Vector2(1, 1))
			$Sprite.play("Run")
		
		JUMP:
			if is_on_floor():
				play_sound(jump_sound)
				if Input.is_action_just_pressed("ui_up"):
						motion.y = JUMP_HEIGHT
				if friction == true:
					motion.x = lerp(motion.x, 0, 0.2)
			else:
				if Input.is_action_just_pressed("ui_attack"):
					_change_state(ATTACK)
				elif Input.is_action_pressed("ui_left"):
					motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
					$Sprite.flip_h = true
					$Area2D.set_scale(Vector2(-1, 1))
				elif Input.is_action_pressed("ui_right"):
					motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
					$Sprite.flip_h = false
					$Area2D.set_scale(Vector2(1, 1))
				if motion.y < 0:
					$Sprite.play("Jump")
				elif motion.y > 0:
					$Sprite.play("Fall")
					if friction == true:
						motion.x = lerp(motion.x, 0, 0.05)
					
		
		ATTACK:
			attack_is_over = false
			$Sprite.play("Melee2")
			play_sound(sword_sound)
			if $Sprite.get_frame() == 3:
				var bodies = $Area2D.get_overlapping_bodies()
				##print(bodies)
				for body in bodies:
					if body.is_in_group("Enemy"):
						print(body)
						body.take_damage(damage)
			if $Sprite.get_frame() == 5:
				attack_is_over = true
#			

		HURT:
			$Sprite.play("Hurt")
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)
		
		DIE:
			$Sprite.play("Death")
			if $Sprite.get_frame() == 6:
				get_tree().reload_current_scene()

func _physics_process(delta):
	
	if max_depth and position.y > max_depth:
		get_tree().reload_current_scene()

	motion.y += GRAVITY


	if health < 1:
		_change_state(DIE)

	elif Input.is_action_just_pressed("ui_attack"):
		_change_state(ATTACK)

	elif Input.is_action_just_pressed("ui_up"):
		_change_state(JUMP)

	elif Input.is_action_pressed("ui_right"):
		_change_state(RUNRIGHT)

	elif Input.is_action_pressed("ui_left"):
		_change_state(RUNLEFT)

	else :
		if health == max_health:
			_change_state(IDLE)
		elif health < max_health && health > 1:
			_change_state(HURT)

	motion = move_and_slide(motion, UP)


	
	
#helper func so that the player can take damage
func take_damage(count):

	health -= count
	emit_signal("health_changed", health)
	if health <= 0:
		health = 0

		emit_signal("health_changed", health)
		print("Character died")
		return

