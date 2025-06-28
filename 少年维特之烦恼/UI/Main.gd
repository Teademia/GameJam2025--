extends CanvasLayer
class_name GameEnterMain

@export var BeginButton:Button
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	BeginButton.pressed.connect(EnterGame)

func EnterGame()->void:
	ExSceneManager.ChangeSceneWithLoading("res://Tutorial.tscn")
