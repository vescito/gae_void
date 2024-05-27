extends Node2D

var level : int 

@onready var levelText : Label = %LevelText
@export var lines = []
@export var tilemaps = []
@onready var return_button = $"../Control2/Return_button" as Button

var currentTileMapIndex : int

# Called when the node enters the scene tree for the first time.
func _ready():
	currentTileMapIndex = 0
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
	return_button.button_down.connect(on_return_pressed)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	levelText.text = "Level: " + str(level)
	pass

func _on_restart_button_pressed():
	get_tree().reload_current_scene()

func on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://mainmenu/main_menu.tscn")

func nextLevel():
	currentTileMapIndex+=1
	if(currentTileMapIndex >2):
		currentTileMapIndex = 0
	setTileMapActive(currentTileMapIndex)
	level+=1

func setTileMapActive(index):
	get_node(tilemaps[index]).visible = true
	if(index == 0):
		get_node(tilemaps[1]).visible = false
		get_node(tilemaps[2]).visible = false
	elif (index == 1):
		get_node(tilemaps[0]).visible = false
		get_node(tilemaps[2]).visible = false
	else:
		get_node(tilemaps[0]).visible = false
		get_node(tilemaps[1]).visible = false
