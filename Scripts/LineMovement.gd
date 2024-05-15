extends CharacterBody2D

var speed = 100  
var current_line
var current_target_index = 1  
var on_line = true  

var moveForward : bool;

var isFinished : bool

func _ready():
	moveForward = true
	isFinished = false
	new_line()


func _physics_process(delta):
	if on_line:
		move_along_line(delta)

func move_along_line(delta):
	
	
	var line_points = current_line.points
	var target = line_points[current_target_index]
	var direction = (target - position).normalized()
	var movement = direction * speed * delta


	position += movement

	if position.distance_to(target) < speed * delta:
		if current_target_index < line_points.size() - 1:
			current_target_index += 1  
		else:
			on_line = false  

func new_line():
	var lines = [
		%Line2D_1,
		%Line2D_2,
		%Line2D_3,
		%Line2D_4
	]
	current_line = lines[randi() % lines.size()]
	position = current_line.points[0] 

func change_line(line1, line2):
	if current_line == line1:
		current_line = line2
	elif current_line == line2:
		current_line = line1

func _on_crossing_take_turn(l1, l2):
	change_line(l1, l2)
	pass # Replace with function body.


func _on_finish_body_entered(body):
	print("ROUND FINISHED")
	isFinished = true
	pass # Replace with function body.
