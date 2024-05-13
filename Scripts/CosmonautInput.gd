extends Sprite2D

@onready var rigidbody2D : RigidBody2D =  %Cosmonaut
@onready var boopSound : AudioStreamPlayer2D = %Boop

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		if get_rect().has_point(to_local(event.position)):
			var random_movement = randi_range(-200, 200)
			rigidbody2D.apply_impulse(Vector2(random_movement, -1200))
			var random_torque = randi_range(-2000, 2000)
			rigidbody2D.apply_torque_impulse(random_torque)
			boopSound.play()
			print("Cosmonaut clicked!")
