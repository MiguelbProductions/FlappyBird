extends KinematicBody2D

onready var txt_Points = $txt_Points

export var velocity = 0

func _ready():
	txt_Points.text = "0"

func _process(delta):
	if (GameManager.game_started):
		move_and_slide(Vector2(velocity, 0))
		
		txt_Points.text = str(GameManager.points)
