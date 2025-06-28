extends CanvasLayer
class_name WeChatWindow

signal Choose1s
signal Choose2s
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Choose1.pressed.connect(Choose1)
	$Choose2.pressed.connect(Choose2)

func Choose1()->void:
	Choose1s.emit()
	queue_free()

func Choose2()->void:
	Choose2s.emit()
	queue_free()
