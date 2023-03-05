extends KinematicBody2D

export var velocity = 0

var player_vector = Vector2()

func _physics_process(delta):
	player_vector.x = velocity
	
	if (GameManager.game_started):
		move_and_slide(player_vector)
