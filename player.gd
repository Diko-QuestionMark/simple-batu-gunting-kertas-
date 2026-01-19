extends CharacterBody2D


const SPEED = 200.0
const JUMP_VELOCITY = -300.0

@onready var wujudKarakter = $AnimatedSprite2D


func _physics_process(delta: float) -> void:
	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta

	# Handle jump.
	if Input.is_action_just_pressed("space") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction and handle the movement/deceleration.
	# As good practice, you should replace UI actions with custom gameplay actions.
	var direction := Input.get_axis("a", "d")
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)
	
	
	
	if direction == 1:
		wujudKarakter.flip_h = false
	elif direction == -1:
		wujudKarakter.flip_h = true
	
	if velocity.x == 0:
		wujudKarakter.play("idle")
	else:
		wujudKarakter.play("walk")


	move_and_slide()
