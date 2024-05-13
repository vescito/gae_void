extends CharacterBody2D

var speed = 100  # Pixels per second
var current_target_index = 1  # Start moving towards the first point (index 0 is the start point)
var on_line = true  # Check if character is supposed to be moving on line

func _ready():
	position = %Line2D_1.points[0]  # Start at the first point of the line

func _physics_process(delta):
	if on_line:
		move_along_line(delta)

func move_along_line(delta):
	var line_points = %Line2D_1.points
	var target = line_points[current_target_index]
	var direction = (target - position).normalized()
	var movement = direction * speed * delta

	# Update position directly
	position += movement

	# Check if close enough to consider having reached the target
	if position.distance_to(target) < speed * delta:
		if current_target_index < line_points.size() - 1:
			current_target_index += 1  # Move to next target
		else:
			on_line = false  # Stop moving if at the end of the line
