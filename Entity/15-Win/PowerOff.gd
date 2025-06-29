extends CanvasLayer


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$End.pressed.connect(Change)
	$Wait.pressed.connect(Reload)
	
func Reload()->void:
	ExSceneManager.Reload()
	
func Change()->void:
	ExSceneManager.ChangeSceneWithLoading("res://Levels/EnterGame.tscn")
