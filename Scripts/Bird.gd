extends KinematicBody2D

export var velocity = 0
export var gravity = 0
export var jump_force = 0

var bird_vector = Vector2()

func get_input():
	if (Input.is_action_just_pressed("Jump")):
		bird_vector.y = jump_force
	
	bird_vector.x = velocity
	bird_vector.y += gravity

func apply_animation():
	if (bird_vector.y > 0):
		self.rotation_degrees = 30
	else:
		self.rotation_degrees = -30

func _physics_process(delta):
	if (GameManager.game_started):
		get_input()
		apply_animation()
		
		move_and_slide(bird_vector)
	else:
		if (Input.is_action_just_pressed("Jump")):
			GameManager.game_started = true
