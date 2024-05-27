extends Control

@onready var return_button = $return_button as Button


# Called when the node enters the scene tree for the first time.
func _ready():
	return_button.button_down.connect(on_return_pressed)

func on_return_pressed() -> void:
	get_tree().change_scene_to_file("res://mainmenu/main_menu.tscn")

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass
