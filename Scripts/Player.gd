extends KinematicBody2D

export var velocity = 0

var player_vector = Vector2()

func _ready():
	player_vector.x = velocity

func _physics_process(delta):
	if (GameManager.game_started):
		move_and_slide(player_vector)
