extends CharacterBody2D

var speed = 150
var current_line
var current_target_index = 1  
var on_line = true  

var moveForward : bool

var lines

func _ready():
	moveForward = true
	lines = [
		%LINIE_1,
		%LINIE_2,
		%LINIE_3,
		%LINIE_4
	]
	new_line()

func _physics_process(delta):
	if on_line:
		move_along_line(delta)

func move_along_line(delta):
	var line_points = current_line.points
	var target_index = current_target_index if moveForward else line_points.size() - 1 - current_target_index
	var target = line_points[target_index]
	var direction = (target - position).normalized()
	var movement = direction * speed * delta

	position += movement

	if position.distance_to(target) < speed * delta:
		if moveForward:
			if current_target_index < line_points.size() - 1:
				current_target_index += 1
			else:
				moveForward = false  # Richtung umkehren
				current_target_index -= 1
		else:
			if current_target_index > 0:
				current_target_index -= 1
			else:
				moveForward = true  # Richtung umkehren
				current_target_index += 1

func new_line():
	current_line = lines[randi() % lines.size()]
	position = current_line.points[0]
	current_target_index = 1 if moveForward else current_line.points.size() - 2

func change_line(line1, line2):
	if current_line == line1:
		current_line = line2
	elif current_line == line2:
		current_line == line1

func _on_crossing_take_turn(l1, l2, move_Forward):
	print("Signal angekommen")
	change_line(l1, l2)
	if !(current_line == lines[0] or current_line == lines[1] or current_line == lines[2] or current_line == lines[3]):
		moveForward = move_Forward
	else:
		moveForward = true

func _on_main_scene_turn(l1, l2, mf):
	print("Signal angekommen")
	change_line(l1, l2)
	if !(current_line == lines[0] or current_line == lines[1] or current_line == lines[2] or current_line == lines[3]):
		moveForward = mf
	else:
		moveForward = true

# Entferne oder kommentiere den Game Over Code
# func _on_finish_1_body_entered(body, extra_arg_0):
# 	print("BODY ENTERED")
# 	print("ROUND FINISHED")
# 	if speed < 225:
# 		speed += 15
# 	$"../Mechanics".nextLevel()
# 	var line = current_line
# 	new_line()
# 	print(speed
