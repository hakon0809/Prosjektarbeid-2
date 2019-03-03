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
	
	if Input.is_action_pressed("ui_right"):
		if !$Sprite.get_animation() == "Melee2":
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		if !$Sprite.get_animation() == "Melee2":
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$Sprite.play("Run")
	elif Input.is_action_pressed("ui_attack"):
		$Sprite.play("Melee2")
	elif health < max_health && health > 0:
		$Sprite.play("Hurt")
	elif health < 1:
		$Sprite.play("Death")
		set_physics_process(false)
	else:
		if !$Sprite.get_animation() == "Melee2" || $Sprite.get_frame() == 5 || $Sprite.get_animation() == "Death" || $Sprite.get_animation() == "Hurt":
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
			motion.y = JUMP_HEIGHT
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.2)
	else:
		if motion.y < 0:
			$Sprite.play("Jump")
		elif motion.y > 0:
			$Sprite.play("Fall")
		if friction == true:
			motion.x = lerp(motion.x, 0, 0.05)
	
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


