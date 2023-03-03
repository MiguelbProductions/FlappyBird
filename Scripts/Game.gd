extends Node2D

onready var PipeTime_Generation = $PipeTime_Generation

onready var Point_Sound = $Sounds/Point_Sound

onready var Player = $Player
onready var Bird = $Player/Bird
onready var Points_Counter = $Player/GUI

var Pipe = preload("res://Scenes/Pipe.tscn")

var random = RandomNumberGenerator.new()

var pipes_spawing = false

func _on_PipeTime_Generation_timeout():
	var pipe_top = Pipe.instance()
	var pipe_bottom = Pipe.instance()
	
	random.randomize()
	var center_point = random.randi_range(170, 325)
	
	random.randomize()
	var pipes_opening = random.randi_range(390, 450)
	
	pipe_top.position = Vector2(Player.position.x + 400, center_point - pipes_opening/2)
	pipe_bottom.position = Vector2(Player.position.x + 400, center_point + pipes_opening/2)
	
	pipe_top.rotation_degrees = 180
	
	add_child(pipe_top)
	add_child(pipe_bottom)
	
	GameManager.list_of_pipeoverpasspos.append(int(Player.position.x + 400))
	print(pipes_opening)
	print(GameManager.list_of_pipeoverpasspos)
	
	random.randomize()
	PipeTime_Generation.start(random.randf_range(1.5, 3.5))

func _on_Collision_Detector_body_entered(body):
	finish_game()

func verify_overtaking():
	if (GameManager.list_of_pipeoverpasspos.size() > 0):
		if (GameManager.list_of_pipeoverpasspos[0] <= int(Player.position.x)):
			GameManager.list_of_pipeoverpasspos.pop_at(0)
			
			GameManager.points += 1
			
			Point_Sound.play()

func verify_limits():
	if (Bird.position.y >= 528 or Bird.position.y <= 0):
		finish_game()

func pipes_generation():
	if (GameManager.game_started and !pipes_spawing):
		pipes_spawing = true
		
		random.randomize()
		PipeTime_Generation.start(random.randf_range(1, 1.75))
		
func finish_game():
	GameManager.game_started = false
	GameManager.list_of_pipeoverpasspos = []
	GameManager.points = 0
	
	get_tree().reload_current_scene()

func _input(event):
	if event is InputEventScreenTouch:
		if (event.is_pressed() and not GameManager.game_started):
			GameManager.game_started = true

func _physics_process(delta):
	if (GameManager.game_started):
		verify_limits()
		verify_overtaking()
		pipes_generation()
		
	elif (Input.is_action_just_pressed("Jump") and not GameManager.game_started):
		GameManager.game_started = true
