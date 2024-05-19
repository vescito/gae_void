extends CharacterBody2D

@onready var animated_player = $PlayerAnim


var speed = 100  
var current_line
var current_target_index = 1  
var on_line = true  

var moveForward : bool;

var isFinished : bool

var lines

func _ready():
	moveForward = true
	isFinished = false
	lines = [
		%Line2D_1,
		%Line2D_2,
		%Line2D_3,
		%Line2D_4
	]
	new_line()



func _physics_process(delta):
	if on_line:
		move_along_line(delta)
		animated_player.play("walk")




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
				on_line = false  
		else:
			if current_target_index > 0:
				current_target_index -= 1
			else:
				on_line = false  

func new_line():
	current_line = lines[randi() % lines.size()]
	position = current_line.points[0] 

func change_line(line1, line2):
	if current_line == line1:
		current_line = line2
	elif current_line == line2:
		current_line = line1

# DAS HIER IST FÜR DIE NICHT GENERIERTEN LINES
func _on_crossing_take_turn(l1, l2, move_Forward):
	change_line(l1, l2)
	if!(current_line == lines[0] || current_line == lines[1] || current_line == lines[2] || current_line == lines[3]):
		moveForward = move_Forward
	else:
		moveForward = true
	pass # Replace with function body.


func _on_finish_body_entered(body):
	print("ROUND FINISHED")
	isFinished = true
	speed = 0		# Sonst läuft er immer weiter wenn man eine Brücke neben dem Ziel stellt
	pass # Replace with function body.



# DAS HIER IST FÜR DIE GENERIERTEN LINES
func _on_main_scene_turn(l1, l2, mf):
	change_line(l1, l2)
	if!(current_line == lines[0] || current_line == lines[1] || current_line == lines[2] || current_line == lines[3]):
		moveForward = mf
	else:
		moveForward = true
	pass 
	
	
		
		
