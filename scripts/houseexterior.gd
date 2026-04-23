extends StaticBody2D

var at_door = false

func _process(delta: float) -> void:
	if Input.is_action_pressed("enter") and at_door:
			# make sure to add the "enter" action in Project Settings>Input Map
		get_tree().change_scene_to_file("res://scenes/house.tscn")

func _on_area_2d_body_entered(body: Node2D) -> void:
	# remember to connect the Area2D's body_entered() signal to this function
	if body.name == "Player" and Global.house_unlocked == true:
		at_door = true
		print("at outside door")

func _on_area_2d_body_exited(body: Node2D) -> void:
	# remember to connect the Area2D's body_exited() signal to this function
	if body.name == "Player":
		at_door = false
