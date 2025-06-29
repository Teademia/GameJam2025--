extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"..".HeroEnter.connect(AddWindow)
	

func AddWindow()->void:
	ExSceneManager.AddScene("res://Entity/15-Win/PowerOff.tscn")
