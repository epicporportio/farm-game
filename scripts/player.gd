extends CharacterBody2D

var speed = 60
@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta):
	var motion = Vector2.ZERO

	# Handle movement and movement animations
	if Input.is_action_pressed("up"):
		motion.y = -speed
	elif Input.is_action_pressed("down"):  # Down takes second priority
		motion.y = speed

	# Only check horizontal if no vertical inputs are pressed
	if motion.y == 0:
		if Input.is_action_pressed("left"):
			motion.x = -speed
		elif Input.is_action_pressed("right"):
			motion.x = speed

	# Play the animation based on priority
	if motion.y == -speed:  # Up has the highest priority
		animated_sprite_2d.play("run_back")
	elif motion.y == speed:  # Down
		animated_sprite_2d.play("run_front")
	elif motion.x == -speed:  # Left
		animated_sprite_2d.play("run_left")
	elif motion.x == speed:  # Right
		animated_sprite_2d.play("run_right")
	else:
		animated_sprite_2d.stop()  # Stop animation if no input    if Input.is_action_pressed("ui_up"):


	# Handle idle animations
	if motion == Vector2.ZERO:
		animated_sprite_2d.play("idle_front")
	
	# Execute movement
	velocity = motion.normalized() * speed
	move_and_slide()
