extends CharacterBody2D

var speed = 100  
var current_line
var current_target_index = 1  
var on_line = true  

func _ready():
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
			on_line = false  #

func new_line():
	var lines = [
		%Line2D_1,
		%Line2D_2,
		%Line2D_3,
		%Line2D_4
	]
	current_line = lines[randi() % lines.size()]
	position = current_line.points[0] 

func change_line(line):
	current_line = line
	position = current_line.points[0] 
