extends CanvasLayer
class_name WeChatWindow

signal Choose1s
signal Choose2s
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$Choose1.pressed.connect(Choose1)
	$Choose2.pressed.connect(Choose2)
	$Ensure.pressed.connect(Ensure)
	get_tree().paused=true

func Choose1()->void:
	get_tree().paused=false
	Choose1s.emit()
	$Label.visible=false
	$Choose1.visible=false
	$Choose2.visible=false
	$ChooseText1.visible=true
	$Ensure.visible=true
func Choose2()->void:
	get_tree().paused=false
	Choose2s.emit()
	$Label.visible=false
	$Choose1.visible=false
	$Choose2.visible=false
	$ChooseText2.visible=true
	$Ensure.visible=true

func Ensure()->void:
	queue_free()
