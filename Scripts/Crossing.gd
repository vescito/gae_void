extends Area2D

@export var line1: Line2D
@export var line2: Line2D
@export var moveForward: bool

signal takeTurn(l1, l2, mf)

func _ready():
	self.connect("takeTurn", Callable(%CharacterBody2D, "_on_crossing_take_turn"))
	print("Connected")

func _on_crossing_body_entered(body):
	#get_tree().call_group("player", "_on_crossing_take_turn")
	emit_signal("takeTurn", line1, line2, moveForward)
	pass 
