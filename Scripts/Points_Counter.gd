extends Node

onready var txt_Points = $txt_Points

func _process(delta):
	txt_Points.text = str(GameManager.points)
