extends Node


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_credits_button_pressed():
	$Control.visible = true
	pass # Replace with function body.


func _on_credits_button_2_pressed():
	$Control.visible = false
	pass # Replace with function body.


func _on_play_button_pressed():
	get_tree().change_scene_to_file("res://main_scene.tscn")
	pass # Replace with function body.
