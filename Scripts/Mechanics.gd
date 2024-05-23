extends Node2D

var level : int 

@onready var levelText : Label = %LevelText
# Called when the node enters the scene tree for the first time.
func _ready():
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
