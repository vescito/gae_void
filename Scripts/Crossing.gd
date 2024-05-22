extends Area2D

@export var line1: Line2D
@export var line2: Line2D
@export var moveForward: bool

signal takeTurn(l1, l2, mf)

func _on_crossing_body_entered(body):
	print("Über: ",line1," von/zu ",line2)
	emit_signal("takeTurn", line1, line2, moveForward)
	pass # Replace with function body.
