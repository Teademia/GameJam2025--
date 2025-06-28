extends Area2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	body_entered.connect(DetectHero)
	
func DetectHero(body: Node2D) -> void:
	ExSceneManager.ChangeSceneWithLoading("res://Levels/Level1.tscn")
