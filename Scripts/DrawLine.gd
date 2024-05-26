extends Node2D

var from_position = null
var isInArea = false
var currentArea : String
var previousArea : String

var array1 = []
var array2 = []
var array3 = []

@onready var line1 : Line2D = %LINIE_1
@onready var line2 : Line2D = %LINIE_2
@onready var line3 : Line2D = %LINIE_3
@onready var line4 : Line2D = %LINIE_4

@onready var player = %CharacterBody2D

var instancevoid = preload("res://void.tscn")

var connectionPrefab = preload("res://crossing.tscn")

signal turn(l1, l2, mf)

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
	
	var i = int(randf_range(0, 4))
	var j = int(randf_range(0, 4))
	if(i == 0):
		spawn_voids_on_lines(line1, 1)  
	elif(i == 1):
		spawn_voids_on_lines(line2, 1)  
	elif(i == 2):
		spawn_voids_on_lines(line3, 1)  
	else:
		spawn_voids_on_lines(line4, 1)  
	if(j == 0):
		spawn_voids_on_lines(line1, 1)  
	elif(j == 1):
		spawn_voids_on_lines(line2, 1)  
	elif(j == 2):
		spawn_voids_on_lines(line3, 1)  
	else:
		spawn_voids_on_lines(line4, 1)  


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func createLine(from, to, currentArea, previousArea):
	var l1
	var l2
	var l1_name
	var l2_name
	if(currentArea == "Area2D_1"):
		l1 = line1
		l1_name = "Area2D_1"
	elif(currentArea == "Area2D_2"):
		l1 = line2
		l1_name = "Area2D_2"
	elif(currentArea == "Area2D_3"):
		l1 = line3
		l1_name = "Area2D_3"
	elif(currentArea == "Area2D_4"):
		l1 = line4
		l1_name = "Area2D_4"
	if(previousArea == "Area2D_1"):
		l2 = line1
		l2_name = "Area2D_1"
	elif(previousArea == "Area2D_2"):
		l2 = line2
		l2_name = "Area2D_2"
	elif(previousArea == "Area2D_3"):
		l2 = line3
		l2_name = "Area2D_3"
	elif(previousArea == "Area2D_4"):
		l2 = line4
		l2_name = "Area2D_4"
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
	#print(intersects)


	if intersects == false && (((currentArea == "Area2D_1" && previousArea == "Area2D_2")||(currentArea == "Area2D_2" && previousArea == "Area2D_1")) || ((currentArea == "Area2D_3" && previousArea == "Area2D_2")||(currentArea == "Area2D_2" && previousArea == "Area2D_3")) || ((currentArea == "Area2D_4" && previousArea == "Area2D_3")||(currentArea == "Area2D_3" && previousArea == "Area2D_4"))):
		var new_line = Line2D.new()
		#var connector1 = connectionPrefab.instance()
		#connector1.position = from
		#add_child(connector1)
		#var connector2 = connectionPrefab.instance()
		#connector2.position = to
		#add_child(connector2)
		new_line.points = [from, to]
		var fromInstance = connectionPrefab.instantiate()
		fromInstance.position = from
		if(previousArea == l1_name):
			fromInstance.line1 = l1
		else:
			fromInstance.line1 = l2
		print("l1: " + l1.name)
		print("l2: " + l2.name)
		print("New line: " + new_line.name)
		fromInstance.line2 = new_line
		fromInstance.moveForward = true
		fromInstance.connect("takeTurn", Callable(%CharacterBody2D, "_on_crossing_take_turn"))
		#fromInstance.connect("takeTurn", Callable(self, "test"))
		#fromInstance._on_crossing_body_entered.connect(test(l1, l2, true))
		%"Main Lines".add_child(fromInstance)
		var toInstance = connectionPrefab.instantiate()
		toInstance.position = to
		if(currentArea == l1_name):
			toInstance.line1 = l1
		else:
			toInstance.line1 = l2
		toInstance.line2 = new_line
		toInstance.moveForward = false
		toInstance.connect("takeTurn", Callable(%CharacterBody2D, "_on_crossing_take_turn"))
		#toInstance.connect("takeTurn", Callable(self, "test"))
		#toInstance._on_crossing_body_entered.connect(test(l1, l2, false))
		%"Main Lines".add_child(toInstance)
		%"Main Lines".add_child(new_line)
		if previousArea == "Area2D_1" || currentArea == "Area2D_1":
			array1.append(new_line)
		elif previousArea == "Area2D_4" || currentArea == "Area2D_4":
			array3.append(new_line)
		elif (previousArea == "Area2D_3" && currentArea == "Area2D_2") || (previousArea == "Area2D_2" && currentArea == "Area2D_3"):
			array2.append(new_line)



func _on_area_2d_1_mouse_entered(extra_arg_0):
	#print("Entered at: " + extra_arg_0)
	currentArea = extra_arg_0
	isInArea = true


func _on_area_2d_1_mouse_exited(extra_arg_0):
	#print("Exited at: " + extra_arg_0)
	currentArea = "No area"
	isInArea = false

func get_random_point_on_line(linie: Line2D) -> Vector2:
	print(linie)
	var start_point = linie.get_point_position(0)
	var end_point = linie.get_point_position(1)
	
	var middle_point = start_point.lerp(end_point, 0.5)
	var middle_to_end_point = middle_point.lerp(end_point, 0.5)

	var t = randf()  # Random value between 0 and 1
	return middle_point.lerp(middle_to_end_point, t)

func spawn_voids_on_lines(line: Line2D, void_count: int):
	for i in range(void_count):
		var position = get_random_point_on_line(line)
		var instance = instancevoid.instantiate()
		instance.position = position
		add_child(instance)
		instance.connect("endGame", Callable(%CharacterBody2D, "gameOver"))
		
#func test(l1, l2, mf):
	#print("TAKEN TURN VOM TEST")
	#print(l1)
	#print(l2)
	#print(mf)
	#print("Ende des Tests")
	#print("Über: ",line1," von/zu ",line2)
	#emit_signal("turn", line1, line2, mf)
