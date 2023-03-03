extends KinematicBody2D

onready var Jump_Sound = $Sounds/Jump_Sound

onready var Idle_Animation = $Idle_Animation

export var velocity = 0
export var gravity = 0
export var jump_force = 0

var bird_vector = Vector2()

func get_input():
	if (Input.is_action_just_pressed("Jump")):
		bird_vector.y = jump_force
		
		Jump_Sound.play()
	
	bird_vector.y += gravity

func apply_animation():
	if (bird_vector.y > 0):
		rotation_degrees = 30
	else:
		rotation_degrees = -30
		
	if (Idle_Animation.current_animation == "Idle"):
		Idle_Animation.play("RESET")

func _physics_process(delta):
	if (GameManager.game_started):
		get_input()
		apply_animation()
		
		move_and_slide(bird_vector)
	else:
		if (Idle_Animation.current_animation != "Idle"):
			Idle_Animation.play("Idle")
