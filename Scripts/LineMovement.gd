extends CharacterBody2D

@onready var animated_player = $PlayerAnim


var speed = 130
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
		%LINIE_1,
		%LINIE_2,
		%LINIE_3,
		%LINIE_4
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

	#if position.distance_to(target) < speed * delta:
		#if moveForward:
			#if current_target_index < line_points.size() - 1:
				#current_target_index += 1
			#else:
				#on_line = false  
				#print("offline1")
		#else:
			#if current_target_index > 0:
				#current_target_index -= 1
			#else:
				#on_line = false  
				#print("offline2")

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
	print("Signal angekommen")
	change_line(l1, l2)
	if!(current_line == lines[0] || current_line == lines[1] || current_line == lines[2] || current_line == lines[3]):
		moveForward = move_Forward
	else:
		moveForward = true
	pass # Replace with function body.


# DAS HIER IST FÜR DIE GENERIERTEN LINES
func _on_main_scene_turn(l1, l2, mf):
	print("Signal agekommen")
	change_line(l1, l2)
	if!(current_line == lines[0] || current_line == lines[1] || current_line == lines[2] || current_line == lines[3]):
		moveForward = mf
	else:
		moveForward = true
	pass 
	

func _on_finish_1_body_entered(body, extra_arg_0):
	new_line()
	print("is finished: " + str(isFinished))
	print("BODY ENTERED")
	if(extra_arg_0 == "bad" && isFinished == false):
		gameOver()
	else:
		print("ROUND FINISHED")
		if speed < 200:
			speed += 10
		var line = current_line
		$"../Mechanics".nextLevel()
		isFinished = true
		change_bool_after_delay()
		change_finish_after_delay()

func gameOver():
		speed = 0
		%GameOverLabel.visible = true
		print("GAME OVER")

func shuffleFinished():
	#var colliders = [$"../Main Lines/LINIE_1/Finish_1/CollisionShape2D", $"../Main Lines/LINIE_2/Finish_2/CollisionShape2D", $"../Main Lines/LINIE_3/Finish_3/CollisionShape2D", $"../Main Lines/LINIE_4/Finish_4/CollisionShape2D"]
	#for node in colliders:
	#	node.disabled = true
	var nodes = [$"../Main Lines/LINIE_1/Finish_1", $"../Main Lines/LINIE_2/Finish_2", $"../Main Lines/LINIE_3/Finish_3", $"../Main Lines/LINIE_4/Finish_4"]
	var original_positions = []
	for node in nodes:
		original_positions.append(node.position)

	original_positions.shuffle()
	for i in range(nodes.size()):
		nodes[i].position = original_positions[i]
	#for node in colliders:
	#	node.disabled = false

func change_bool_after_delay() -> void:
	await get_tree().create_timer(1.0).timeout
	isFinished = false

func change_finish_after_delay() -> void:
	await get_tree().create_timer(0.01).timeout
	shuffleFinished()

