extends Area2D

@export var line1: Line2D
@export var line2: Line2D
@onready var connectors = %Connectors

signal takeTurn(l1, l2)

func _on_crossing_body_entered(body):
	emit_signal("takeTurn", line1, line2)
	pass # Replace with function body.
