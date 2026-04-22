extends Node

var at_door = false

# Called when the node enters the scene tree for the first time.
const coin_node = preload("res://scenes/coin.tscn")

const coins_to_create = [
   Vector2(555, 350),
   Vector2(800, 400),
   Vector2(300, 300),
   Vector2(123, 500),
   Vector2(456, 200),
	]
# add a bunch of places to create coins at
var coin_nodes = []
var map_bounds: Rect2

func _ready() -> void:
	for coin in coins_to_create:
		var coin_instance = coin_node.instantiate()
		coin_instance.position = coin
		add_child(coin_instance)
		coin_nodes.append(coin_instance)
	_connect_signals()
func _on_area_2d_body_entered(body: Node2D) -> void:
	# remember to connect the Area2D's body_entered() signal to this function
	if body.name == "Player":
		at_door = true
		print("at inside door")

func _on_area_2d_body_exited(body: Node2D) -> void:
	if body.name == "Player":
		at_door = false

func _connect_signals():
	for coin in coin_nodes:
		# this refers to the coin nodes we've instantiated
		coin.collected.connect(_coin_collected)
		# connect the "collected" signal to the function below
		# (we haven't created the "collected" signal yet)
			
func _coin_collected():
	$TileMapLayer/Player.increase_score("coins")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_pressed("enter") and at_door:
		get_tree().change_scene_to_file("res://scenes/mainscene.tscn")
