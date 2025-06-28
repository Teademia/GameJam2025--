extends CanvasLayer
class_name GameEnterMain

@export var BeginButton:Button
func _ready() -> void:
	BeginButton.pressed.connect(EnterGame)

func EnterGame()->void:
	ExSceneManager.ChangeSceneWithLoading("res://Levels/Tutorial.tscn")
