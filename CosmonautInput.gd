extends Sprite2D

@onready var rigidbody2D : RigidBody2D =  %Cosmonaut

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			rigidbody2D.apply_impulse(Vector2(0, -1200))
			print("You clicked on Sprite!")
