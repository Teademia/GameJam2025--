extends CanvasLayer
class_name NoteBookWindow

func _ready() -> void:
	$Ensure.pressed.connect(queue_free)
