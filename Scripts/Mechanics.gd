extends Node2D

var level : int 

@onready var levelText : Label = %LevelText
@export var lines = []

# Called when the node enters the scene tree for the first time.
func _ready():
	for line in lines:
		var node = get_node(line)
		print(node.name)
		if randi() % 100 < 40:  
			print("a")
			node.set_process(false) 
			node.visible = false
			for n in node.get_children():
				node.remove_child(n)
	level = 1
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	levelText.text = "Level: " + str(level)
	pass

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func nextLevel():
	level+=1
