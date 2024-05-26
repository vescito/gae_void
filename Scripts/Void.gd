extends Area2D

signal endGame()

func _ready():
	self.connect("endGame", Callable(%CharacterBody2D, "_on_body_entered"))
	print("Connected")


func _on_body_entered(body):
	emit_signal("endGame")
	pass # Replace with function body.
