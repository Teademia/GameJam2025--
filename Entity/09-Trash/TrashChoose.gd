extends CanvasLayer
class_name TrashChooseWindow
signal SoftWareDeleted
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Button.pressed.connect(Delete)
	$Button2.pressed.connect(NoDelete)
	get_tree().paused=true
		
func Delete()->void:
	match $OptionButton.selected:
		0:
			SoftWareDeleted.emit("Bilibili")
		1:
			SoftWareDeleted.emit("Trash")
		2:
			SoftWareDeleted.emit("FileFolder")
	get_tree().paused=false
	queue_free()
	
func NoDelete()->void:
	get_tree().paused=false
	queue_free()
