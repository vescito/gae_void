extends Node2D

var from_position = null
var isInArea = false
var currentArea : String
var previousArea : String

var array1 = []
var array2 = []
var array3 = []


func _input(event):

	if isInArea == true:
		if event is InputEventMouseButton:
			if event.button_index == MOUSE_BUTTON_LEFT:
				if event.pressed:
					previousArea = currentArea
					from_position = get_viewport().get_mouse_position()
				else:
					print("Current area is: " + currentArea)
					print("Previous area is: " + previousArea)
					if currentArea != previousArea:
						createLine(from_position, get_local_mouse_position(), currentArea, previousArea)
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func createLine(from, to, currentArea, previousArea):
	var new_line = Line2D.new()
	new_line.points = [from, to]
	add_child(new_line)
	if previousArea == "Area2D_1" || currentArea == "Area2D_1":
		array1.append(new_line)
	elif previousArea == "Area2D_4" || currentArea == "Area2D_4":
		array3.append(new_line)
	elif (previousArea == "Area2D_3" && currentArea == "Area2D_2") || (previousArea == "Area2D_2" && currentArea == "Area2D_3"):
		array2.append(new_line)

func _on_area_2d_1_mouse_entered(extra_arg_0):
	print("Entered at: " + extra_arg_0)
	currentArea = extra_arg_0
	isInArea = true


func _on_area_2d_1_mouse_exited(extra_arg_0):
	print("Exited at: " + extra_arg_0)
	currentArea = "No area"
	isInArea = false
