extends CharacterBody2D

var speed = 300.0
	# choose a speed - i'm lowk checking if you're reading the code here,
	# you should change this value so your player moves faster!!

var direction = Vector2.ZERO
	# at the start the player doesn't have a direction!!

func _physics_process(delta: float) -> void:
	direction = Input.get_vector("left", "right", "up", "down")
	# get the vector (direction for x + y axes combined - you might have done this in maths in school)
	
	velocity = direction * speed
	# velocity is direction combined with speed (you probably did this in physics)
	
	move_and_slide()
