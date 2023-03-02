extends Node2D

onready var PipeTime_Generation = $PipeTime_Generation
onready var Bird = $Bird

var Pipe = preload("res://Scenes/Pipe.tscn")

var random = RandomNumberGenerator.new()

var pipes_opening;

var pipes_spawing = false

func _on_PipeTime_Generation_timeout():
	var pipe_top = Pipe.instance()
	var pipe_bottom = Pipe.instance()
	
	var center_point = random.randi_range(150, 355)
	
	pipes_opening = random.randi_range(400, 450)
	
	pipe_top.position = Vector2(Bird.position.x + 400, center_point - pipes_opening/2)
	pipe_bottom.position = Vector2(Bird.position.x + 400, center_point + pipes_opening/2)
	
	pipe_top.rotation_degrees = 180
	
	add_child(pipe_top)
	add_child(pipe_bottom)
	
	PipeTime_Generation.start(random.randf_range(3, 6.5))

func _on_Collision_Detection_body_entered(body):
	GameManager.game_started = false
	
	get_tree().reload_current_scene()
	
func _physics_process(delta):
	if (GameManager.game_started and !pipes_spawing):
		PipeTime_Generation.start(random.randf_range(1, 2))
		
		pipes_spawing = true
