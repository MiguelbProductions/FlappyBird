extends Node2D

onready var PipeTime_Generation = $PipeTime_Generation
onready var Bird = $Bird

var Pipe = preload("res://Scenes/Pipe.tscn")

var random = RandomNumberGenerator.new()

var pipes_spawing = false

func _on_PipeTime_Generation_timeout():
	var pipe_top = Pipe.instance()
	var pipe_bottom = Pipe.instance()
	
	random.randomize()
	var center_point = random.randi_range(150, 325)
	
	random.randomize()
	var pipes_opening = random.randi_range(400, 440)
	
	pipe_top.position = Vector2(Bird.position.x + 400, center_point - pipes_opening/2)
	pipe_bottom.position = Vector2(Bird.position.x + 400, center_point + pipes_opening/2)
	
	pipe_top.rotation_degrees = 180
	
	add_child(pipe_top)
	add_child(pipe_bottom)
	
	GameManager.list_of_pipeoverpasspos.append(int(Bird.position.x + 443))
	
	random.randomize()
	PipeTime_Generation.start(random.randf_range(1, 3.5))

func _on_Collision_Detector_body_entered(body):
	finish_game()

func finish_game():
	GameManager.game_started = false
	GameManager.list_of_pipeoverpasspos = []
	GameManager.points = 0
	
	get_tree().reload_current_scene()

func _physics_process(delta):
	if (Bird.position.y >= 400 or Bird.position.y <= 0):
		finish_game()
	
	if (GameManager.game_started and !pipes_spawing):
		random.randomize()
		PipeTime_Generation.start(random.randf_range(1, 2))
		
		pipes_spawing = true

