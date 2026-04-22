extends Area2D

signal collected

var freeyourself = false

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _process(delta: float) -> void:
	if freeyourself:
		self.free()
		# remove itself from the current scene

func _on_body_entered(body: Node2D) -> void:
	if body is CharacterBody2D:
		print("collected")
		
		collected.emit()
		# emit the "collected" signal
			
		freeyourself = true
