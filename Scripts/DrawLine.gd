extends Node2D

var from_position = null
var isInArea = false
var currentArea : String
var previousArea : String

var array1 = []
var array2 = []
var array3 = []

var connectionPrefab = preload("res://crossing.tscn")

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
	var area1 = %Area1
	var area2 = %Area2
	var area3 = %Area3
	for child in area1.get_children():
		array1.append(child)
	for child in area2.get_children():
		array2.append(child)
	for child in area3.get_children():
		array3.append(child)



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func createLine(from, to, currentArea, previousArea):
	var intersects : bool
	intersects = false
	if(currentArea == "Area2D_1" || previousArea == "Area2D_1"):
		for line in array1:
			if(Geometry2D.segment_intersects_segment(from, to, line.points[0], line.points[1]) != null):
				intersects = true
	if(previousArea == "Area2D_4" || currentArea == "Area2D_4"):
		for line in array3:
			if(Geometry2D.segment_intersects_segment(from, to, line.points[0], line.points[1]) != null):
				intersects = true
	elif (previousArea == "Area2D_3" && currentArea == "Area2D_2") || (previousArea == "Area2D_2" && currentArea == "Area2D_3"):
		for line in array2:
			if(Geometry2D.segment_intersects_segment(from, to, line.points[0], line.points[1]) != null):
				intersects = true
	print(intersects)


	if intersects == false && (((currentArea == "Area2D_1" && previousArea == "Area2D_2")||(currentArea == "Area2D_2" && previousArea == "Area2D_1")) || ((currentArea == "Area2D_3" && previousArea == "Area2D_2")||(currentArea == "Area2D_2" && previousArea == "Area2D_3")) || ((currentArea == "Area2D_4" && previousArea == "Area2D_3")||(currentArea == "Area2D_3" && previousArea == "Area2D_4"))):
		var new_line = Line2D.new()
		#var connector1 = connectionPrefab.instance()
		#connector1.position = from
		#add_child(connector1)
		#var connector2 = connectionPrefab.instance()
		#connector2.position = to
		#add_child(connector2)
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
