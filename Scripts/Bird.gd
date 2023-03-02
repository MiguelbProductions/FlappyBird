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
	
	bird_vector.x = velocity
	bird_vector.y += gravity

func apply_animation():
	if (bird_vector.y > 0):
		rotation_degrees = 30
	else:
		rotation_degrees = -30
		
	if (Idle_Animation.current_animation == "Idle"):
		Idle_Animation.play("RESET")
	

func verify_overtaking():
	if (int(self.position.x) in GameManager.list_of_pipeoverpasspos):
		GameManager.list_of_pipeoverpasspos.erase(int(self.position.x))
		
		GameManager.points += 1

func _physics_process(delta):
	if (GameManager.game_started):
		get_input()
		apply_animation()
		verify_overtaking()
		
		move_and_slide(bird_vector)
	else:
		if (Input.is_action_just_pressed("Jump") and not GameManager.game_started):
			GameManager.game_started = true
		
		if (Idle_Animation.current_animation != "Idle"):
			Idle_Animation.play("Idle")
