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
   #Vector2(500,0),
	]
# add a bunch of places to create coins at
		
var coin_nodes = []

func _ready() -> void:
	for coin in coins_to_create:
		var coin_instance = coin_node.instantiate()
		coin_instance.position = coin
		add_child(coin_instance)
		coin_nodes.append(coin_instance)
