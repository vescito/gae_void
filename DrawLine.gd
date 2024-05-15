extends Node2D

var from_position = null
var isInArea = false


func _input(event):
	if isInArea == true:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					from_position = get_viewport().get_mouse_position()
				else:
					createLine(from_position, get_local_mouse_position())
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func createLine(from, to):
	var new_line = Line2D.new()
	new_line.points = [from, to]
	add_child(new_line)
	
func _on_area_2d_mouse_exited():
	isInArea = false
	pass 
	
func _on_area_2d_mouse_entered():
	isInArea = true
	pass 
