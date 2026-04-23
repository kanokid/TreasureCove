extends CharacterBody2D

# --- CHALLENGE ACCEPTED! Speed increased to 500.0 ---
var speed = 500.0
	# choose a speed - i'm lowk checking if you're reading the code here,
	# you should change this value so your player moves faster!!

var direction = Vector2.ZERO
	# at the start the player doesn't have a direction!!

# Preload your scenes and textures outside of functions for cleaner code.
# The `const` keyword is perfect here because these paths don't change.
const scorescene_path = preload("res://scenes/player/score.tscn")
const coin_texture = preload("res://coin.png")
const icon1_texture = preload("res://icon.svg")

# This array defines the data for our scores.
# The columns are: [name, starting_count, texture, position]
# These positions are all different to prevent overlap!
var scores_data = [
	["coins", "0", coin_texture, Vector2(-540, -320)]
]
	# ok so this is where we put all the scores we want to track, along with the score we want them
	# to start at, the image we want them to have, and the coordinates we want to put them at.
	# make sure you give each label a different position!! unless you really want them to overlap?
	# you can have them along the top, under the player (like i have them), one in each corner,
	# or even randomly scattered if you want that to make your game extra unique!!

# We define this list *here* (outside any function) so that it can be
# accessed by both _ready() and _physics_process() (or any other function).
var score_labels = []
	# this is where we'll be putting all of our instantiated score nodes,
	# just to save them for when we need to refer to them
	# (for example to check if we have enough of a certain item)


func _ready() -> void:
	# This function runs ONCE when the node enters the scene tree.
	
	# Loop through our data and instantiate score labels:
	for score_info in scores_data:
		# 1. Instantiate the preloaded scene:
		var score_instance = scorescene_path.instantiate()
		
		# 2. Set the variables on the new instance (Assuming the node has these variables defined):
		# score_info[0] is the name ("coins", "bushes", etc.)
		score_instance.counting = score_info[0]
		
		# score_info[1] is the starting value ("5", "0", etc.).
		score_instance.val = int(score_info[1]) # Convert the string to an integer
		score_instance.text = score_info[1] # This is the actual text displayed
		
		# 3. Set the texture (icon) for the label:
		# Assumes the score scene has a TextureRect child node named "TextureRect"
		score_instance.get_node("TextureRect").texture = score_info[2]
		
		# 4. Set the position relative to the parent (Vector2(0, 100), etc.):
		score_instance.position = score_info[3]
		
		# 5. Add the label as a child of the current node (CharacterBody2D):
		add_child(score_instance)
		
		# 6. Save a reference to this new node in our score_labels list:
		score_labels.append(score_instance)
		
		if score_info[0] == "coins":
			score_instance.val = Global.total_coins
			score_instance.text = str(Global.total_coins)

func _physics_process(delta: float) -> void:
	# This function runs every physics frame (usually 60 times per second).
	# This is where we handle movement.
	
	# Get the combined direction vector from input map actions:
	# Assumes you have "left", "right", "up", "down" defined in Project Settings -> Input Map
	direction = Input.get_vector("left", "right", "up", "down")
	# get the vector (direction for x + y axes combined - you might have done this in maths in school)
	# Set the velocity:
	velocity = direction * speed
	# velocity is direction combined with speed (you probably did this in physics)
	# Move the character based on its velocity and handle collisions:
	move_and_slide()

func increase_score(label_counting):
	for score_label in score_labels:
		if score_label.counting == label_counting:
			score_label.val += 1
			Global.total_coins += 1
			score_label.text = str(score_label.val)
		if label_counting == "coins" and score_label.val >= 24:
			print ("you win")
			get_tree().change_scene_to_file("res://scenes/goodending.tscn")
		elif score_label.val == 18:
			Global.house_unlocked = true
