extends Area2D

@export var line1: Line2D
@export var line2: Line2D
@onready var connectors = %Connectors

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Area2D_body_entered(body):
	print("Player has entered the Area2D!")
	if body is CollisionShape2D:
		print("Player has entered the Area2D!")
