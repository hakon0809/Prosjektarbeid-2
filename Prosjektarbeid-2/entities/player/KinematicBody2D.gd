extends KinematicBody2D

const UP = Vector2(0, -1)
const GRAVITY = 20
const ACCELERATION = 50
const MAX_SPEED = 200
const JUMP_HEIGHT = -500
var motion = Vector2()

func _physics_process(delta):

	var friction = false
	
	motion.y += GRAVITY
	
	if Input.is_action_pressed("ui_right"):
		if !$Sprite.get_animation() == "Melee2":
			motion.x = min(motion.x + ACCELERATION, MAX_SPEED)
			$Sprite.flip_h = false
			$Area2D.set_scale(Vector2(1, 1))
			$Sprite.play("Run")
	elif Input.is_action_pressed("ui_left"):
		if !$Sprite.get_animation() == "Melee2":
			motion.x = max(motion.x - ACCELERATION, -MAX_SPEED)
			$Sprite.flip_h = true
			$Area2D.set_scale(Vector2(-1, 1))
			$Sprite.play("Run")
	elif Input.is_action_pressed("ui_attack"):
		$Sprite.play("Melee2")
	else:
		if !$Sprite.get_animation() == "Melee2"|| $Sprite.get_frame() == 5:
			$Sprite.play("Idle")
			friction = true
			motion.x = lerp(motion.x, 0, 0.2)
	
	if $Sprite.get_animation() == "Melee2" && $Sprite.get_frame() == 3:
			var bodies = $Area2D.get_overlapping_bodies()
			#print(bodies)
			for body in bodies:
				if body.is_in_group("Enemy"):
					body.health -= 20
					print(body.health)
	
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
