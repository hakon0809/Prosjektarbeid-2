extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -500
var motion = Vector2()


enum STATES { IDLE, ATTACK, STAGGER, DIE, DEAD}
var current_state = null
var previous_state = null

export var max_health = 10
var health

var damage = 1

func _ready():
	health = max_health

func _physics_process(delta):

	var friction = false
	
	motion.y += GRAVITY
	
#	if Input.is_action_pressed("ui_attack") && Input.is_action_pressed("ui_right") || Input.is_action_pressed("ui_attack") && Input.is_action_pressed("ui_left"):
#		motion.x = 0
#		$Sprite.play("Melee2")

	if Input.is_action_pressed("ui_right"):
		if $Sprite.get_animation() == "Death":
			pass
		else:
			if $Sprite.get_animation() == "Melee2":
				if $Sprite.get_frame() == 5:
					$Area2D.set_scale(Vector2(1, 1))
					$Sprite.play("Run")
				pass
			else:
				motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
				$Sprite.flip_h = false
				$Area2D.set_scale(Vector2(1, 1))
				$Sprite.play("Run")

	elif Input.is_action_pressed("ui_left"):
		if $Sprite.get_animation() == "Death":
			pass
		else:
			if $Sprite.get_animation() == "Melee2":
				if $Sprite.get_frame() == 5:
					$Area2D.set_scale(Vector2(-1, 1))
					$Sprite.play("Run")
				pass
			else:
				motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
				$Sprite.flip_h = true
				$Area2D.set_scale(Vector2(-1, 1))
				$Sprite.play("Run")
	elif health < max_health && health > 0:
		motion.x = 0
		if not $Sprite.get_animation() == "Melee2":
			$Sprite.play("Hurt")
		if $Sprite.get_animation() == "Melee2" && $Sprite.get_frame() == 5:
			$Sprite.play("Hurt")
	elif health < 1:
		$Sprite.play("Death")
		motion.x = 0
		if $Sprite.get_frame() == 6:
			set_physics_process(true)
			get_tree().reload_current_scene()
	else:
		if not $Sprite.get_animation() == "Melee2" || $Sprite.get_frame() == 5 || $Sprite.get_animation() == "Death" || $Sprite.get_animation() == "Hurt":
			$Sprite.play("Idle")
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)
			
	if $Sprite.get_animation() == "Melee2" && $Sprite.get_frame() == 3:
		var bodies = $Area2D.get_overlapping_bodies()
		##print(bodies)
	
		for body in bodies:
			
			if body.is_in_group("Enemy"):
				print(body)
				body.take_damage(damage)
		
		
	if is_on_floor():
		if Input.is_action_just_pressed("ui_up"):
			if not $Sprite.get_animation() == "Death":
				motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if not $Sprite.get_animation() == "Death":
			if motion.y < 0:
				if $Sprite.get_animation() == "Melee2":
					if $Sprite.get_frame() == 5:
						$Area2D.set_scale(Vector2(1, 1))
						$Sprite.play("Jump")
				else:
					$Sprite.play("Jump")
			elif motion.y > 0:
				if $Sprite.get_animation() == "Melee2":
					if $Sprite.get_frame() == 5:
						$Area2D.set_scale(Vector2(1, 1))
						$Sprite.play("Fall")
				else:
					$Sprite.play("Fall")
			if friction == true:
				motion.x = lerp(motion.x, 0, 0.05)
		
	if Input.is_action_just_pressed("ui_attack"):
		$Sprite.play("Melee2")
		friction = true
		motion.x = lerp(motion.x, 0, 0.05)
		if $Sprite.get_frame() == 5:
			$Sprite.play("Idle")
			
	motion = move_and_slide(motion, UP)


	
	
func take_damage(count):

	health -= count
	if health <= 0:
		health = 0
	##	_change_state(DEAD)
#		emit_signal("died")
		print("Character died")
		return

	##emit_signal("health_changed", health)
	