extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -500
var motion = Vector2()
var friction = false

var sword_sound = load("res://entities/player/sounds/sword-gesture1.ogg")
onready var sound_player = $"../AudioStreamPlayer"

enum Weapons { FISTS, SWORD } 

const ARROW = preload("res://entities/player/player_arrow.tscn")
var timer = null


#Different possible states, have not implemented STAGGER
enum STATES { IDLE, GETUP, KNOCKDOWN, RUNLEFT, RUNRIGHT, JUMP, ATTACK, HURT, DIE, STAGGER, BOW}

signal health_changed
signal died

var current_state = null
var previous_state = null
var next_state = null

var idle_animation = "Idle"
var current_weapon = FISTS
var previous_weapon = null
var next_weapon = null

var attack_animation = null
var attack_frame = null
var attack_over_frame = null

var can_shoot = false
var has_bow = null
var not_shot = true

#var to check if attack is over
var attack_is_over = true
var damage_immunity = false

export var max_health = 10
var health

var damage = 1

var max_depth = null

func _ready():
	set_max_health()
	set_sword_upgrade()
	set_bow_upgrade()
	health = max_health
	
	timer = Timer.new()
	timer.set_one_shot(true)
	timer.set_wait_time(0.3)
	timer.connect("timeout", self, "on_timeout")
	add_child(timer)
	
	if get_tree().get_current_scene().get("max_depth"):
		max_depth = get_tree().get_current_scene().get("max_depth")
	current_state = JUMP
	emit_signal("health_changed", health)
	
func play_sound(sound, volume = 0):
	sound_player.stream = sound
	sound_player.volume_db = volume
	sound_player.play()

#returns true if state change is possible 
func is_change_state_possible():
	
		if current_state == DIE:
			return false
		elif previous_state == DIE:
			return false
			
		elif previous_state == KNOCKDOWN && next_state == GETUP:
			return true
			
		elif current_state == KNOCKDOWN:
			return false
		elif previous_state == KNOCKDOWN:
			return false
			
		elif current_state == GETUP && $Sprite.get_frame() == 6:
			return true
			
		elif current_state == GETUP:
			return false
		elif previous_state == GETUP:
			return false
			
		elif current_state == BOW && $Sprite.get_frame() == 8:
			return true
			
		elif current_state == BOW:
			return false
		elif previous_state == BOW:
			return false
	
		elif not attack_is_over:
			return false

		elif not is_on_floor() && next_state == ATTACK || not is_on_floor() && previous_state == ATTACK :
			return true
			
		elif not is_on_floor() && next_state == JUMP  && current_state == RUNLEFT\
		|| not is_on_floor() && next_state == JUMP && current_state == RUNRIGHT:
			return true
			
		elif not is_on_floor() && next_state == JUMP  && current_state == IDLE:
			return true
		
		elif not is_on_floor() && next_state == KNOCKDOWN:
			return true
		
			
			
		elif not is_on_floor():
			return false
		else:
			return true
		
		
func change_weapon(new_weapon):
	previous_weapon = current_weapon
	next_weapon = new_weapon
	current_weapon = new_weapon
	
	match current_weapon:
		FISTS:
			idle_animation = "Idle"
			attack_animation = "Punch"
			attack_frame = 1
			attack_over_frame = 3
			damage = 1
			
		SWORD:
			idle_animation = "Idle Sword"
			attack_animation = "Melee2"
			attack_frame = 3
			attack_over_frame = 5
			damage = 2
			
			

func on_timeout():
	can_shoot=true
	


#Changes player state
func change_state(new_state):
	previous_state = current_state
	next_state = new_state
	
	if is_change_state_possible():
		current_state = new_state

	
	match current_state:
		IDLE:
			$Sprite.play(idle_animation)
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)
			
		KNOCKDOWN:
			damage_immunity = true
			$Sprite.play("Knockdown")
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)
			if $Sprite.get_frame() == 6 && is_on_floor():
				change_state(GETUP)
			
			
		GETUP:
			$Sprite.play("Get Up")
			friction = false
			motion.x = 0
      
			if $Sprite.get_frame() == 5:
				damage_immunity = false
				
		
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
				if Input.is_action_just_pressed("ui_up"):
					motion.y = JUMP_HEIGHT
				if friction == true:
					motion.x = lerp(motion.x, 0, 0.05)
			else:
				if Input.is_action_pressed("ui_left"):
					motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
					$Sprite.flip_h = true
					$Area2D.set_scale(Vector2(-1, 1))
					
				elif Input.is_action_pressed("ui_right"):
					motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
					$Sprite.flip_h = false
					$Area2D.set_scale(Vector2(1, 1))
					
				elif Input.is_action_just_pressed("ui_attack"):
						change_state(ATTACK)
					
				if motion.y < 0:
					$Sprite.play("Jump")
				elif motion.y > 0:
					$Sprite.play("Fall")
					if friction == true:
						motion.x = lerp(motion.x, 0, 0.05)
					
		
		ATTACK:
			attack_is_over = false
			$Sprite.play(attack_animation)
			play_sound(sword_sound, -10)
			if $Sprite.get_frame() == attack_frame:
				var bodies = $Area2D.get_overlapping_bodies()
				##print(bodies)
				for body in bodies:
					if body.is_in_group("Enemy"):
						print(body)
						body.hitstun = 10
						body.knockdir = global_transform.origin - body.global_transform.origin
						body.take_damage(damage)
			if $Sprite.get_frame() == attack_over_frame:
				attack_is_over = true
				if not is_on_floor():
					change_state(JUMP)

		BOW:
			$Sprite.play("Ranged")
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)
			
			if $Sprite.get_frame() == 7:
				if not_shot:
					var player_arrow = ARROW.instance()
					get_tree().get_current_scene().add_child(player_arrow)
					
					if $Sprite.flip_h == false:
						player_arrow.speed= player_arrow.speed
						player_arrow.position = $Position2D.global_position
					else:
						player_arrow.speed= -player_arrow.speed
						player_arrow.position = $Position2D.global_position -Vector2(70,0)
					not_shot = false
					can_shoot = false

		HURT:
			$Sprite.play("Hurt")
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)
		
		DIE:
			$Sprite.play("Death")
			if $Sprite.get_frame() == 6:
				restart_level()

func _physics_process(delta):
	motion.y += GRAVITY
	
	if current_state == KNOCKDOWN:
		if Engine.get_frames_drawn() % 2 != 0:
			self.modulate.a = 0.2
		else:
			self.modulate.a = 1
	else:
		self.modulate.a = 1

	if max_depth and position.y > max_depth:
		restart_level()
		
	elif health < 1:
		change_state(DIE)

	elif Input.is_action_just_pressed("ui_up"):
		change_state(JUMP)
		
		
	elif Input.is_action_just_pressed("ui_attack"):
		timer.start()
		
	
	elif Input.is_action_just_released("ui_attack"):
		#Check for NPC conversation
		if get_parent().getDiDialogueSource() != null:
			get_node(get_parent().getDiDialogueSource()).converse()
		elif can_shoot && has_bow:
			not_shot = true
			change_state(BOW)
			timer.stop()
		else:
			change_state(ATTACK)
			timer.stop() 
			
	elif not is_on_floor():
		change_state(JUMP)
	
	elif Input.is_action_pressed("ui_right"):
		change_state(RUNRIGHT)

	elif Input.is_action_pressed("ui_left"):
		change_state(RUNLEFT)
		
			
		

	else :
		if health <= max_health && health >= 5:
			change_state(IDLE)
		elif health < 5 && health > 0:
			change_state(HURT)

	motion = move_and_slide(motion, UP)


func restart_level():
	get_tree().reload_current_scene()
	
	
#helper func so that the player can take damage
func take_damage(count):
	if not damage_immunity:
		health -= count
		if health <= 0:
			health = 0
		emit_signal("health_changed", health)
		change_state(KNOCKDOWN)

		
func upgrade_changed(upgrade):
	if upgrade == 1:
		set_max_health()
		health = max_health
		emit_signal("health_changed", health)
	if upgrade == 2:
		set_sword_upgrade()
	if upgrade == 3:
		set_bow_upgrade()

func set_max_health():
	if Globals.get_upgrade(1):
		max_health = 15
	else:
		max_health = 10
	get_parent().get_node("Interface").set_health_bar(max_health)

func set_sword_upgrade():
	if Globals.get_upgrade(2):
		change_weapon(SWORD)
	else:
		pass
		change_weapon(FISTS)

func set_bow_upgrade():
	if Globals.get_upgrade(3):
		has_bow = true
	else:
		has_bow = false

