extends Node2D

var from_position = null

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_LEFT:
			pass
			#print("a")
			#if event.pressed:
				#from_position = get_area_under_mouse()
			#elif from_position:
				#var to_position = get_area_under_mouse()
				#if to_position and to_position != from_position:
					#line2d.points = [from_position, to_position]
					#from_position = null  # Reset start position
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func _on_Area2D_mouse_entered():
	print("trueaaa")
	
func _on_area_2d_mouse_exited():
	print("SAA")
	pass # Replace with function body.
