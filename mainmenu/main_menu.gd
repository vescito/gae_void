class_name MainMenu 
extends Control

@onready var play_button = $MarginContainer/HBoxContainer/VBoxContainer/Play_button as Button
@onready var exit_button = $MarginContainer/HBoxContainer/VBoxContainer/Exit_button as Button
@onready var start_level = preload("res://main_scene.tscn")
@onready var tutorial_button = $MarginContainer/HBoxContainer/VBoxContainer/Tutorial_button as Button
@onready var start_tutorial = preload("res://mainmenu/tutorial/control.tscn")

# Called when the node enters the scene tree for the first time.
func _ready():
	play_button.button_down.connect(on_start_pressed)
	tutorial_button.button_down.connect(on_tutorial_pressed)
	exit_button.button_down.connect(on_exit_pressed)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func on_start_pressed() -> void:
	get_tree().change_scene_to_packed(start_level)


func on_tutorial_pressed() -> void:
	get_tree().change_scene_to_packed(start_tutorial)


func on_exit_pressed() -> void:
	get_tree().quit()
