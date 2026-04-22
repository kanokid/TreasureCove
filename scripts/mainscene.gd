extends Node

const coin_node = preload("res://scenes/coin.tscn")

const coins_to_create = [
   Vector2(225, 0),
   Vector2(100, 200),
   Vector2(400, 300),
   Vector2(123, 456),
   Vector2(456, -100),
   Vector2(-100, -200),
   Vector2(350, -350),
   Vector2(30, -175),
   Vector2(-25, 0),
   Vector2(-60,400),
   Vector2(300,100),
   Vector2(0,-500),
   Vector2(500, -500),
   Vector2(900, -500),
   Vector2(900, 500),
   Vector2(0, 500),
   Vector2(-500, 1000),
   Vector2(900, 1000),
   Vector2(0, 1000),
	]
# add a bunch of places to create coins at
		
var coin_nodes = []
var map_bounds: Rect2

func _ready() -> void:
	var used = $TileMapLayer.get_used_rect()
	var ts = $TileMapLayer.tile_set.tile_size
	map_bounds = Rect2(Vector2(used.position) * Vector2(ts), Vector2(used.size) * Vector2(ts))
	
	for coin in coins_to_create:
		var coin_instance = coin_node.instantiate()
		coin_instance.position = coin
		add_child(coin_instance)
		coin_nodes.append(coin_instance)
	_connect_signals()

func _process(_delta: float) -> void:
	if not map_bounds.has_point($Player.position):
		get_tree().change_scene_to_file("res://scenes/badending.tscn")
			
func _connect_signals():
	for coin in coin_nodes:
		# this refers to the coin nodes we've instantiated
		coin.collected.connect(_coin_collected)
		# connect the "collected" signal to the function below
		# (we haven't created the "collected" signal yet)
			
func _coin_collected():
	$Player.increase_score("coins")
	# we also haven't created this function in the player's script yet
