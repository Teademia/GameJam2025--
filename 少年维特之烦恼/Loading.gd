extends CanvasLayer
class_name Loading
@onready var Rect:ColorRect=$ColorRect

func _ready() -> void:
	FadeOut()
	
# 淡出：从黑到透明（覆盖内容）
func FadeIn(duration: float = 0.5) -> void:
	$AnimationPlayer.play("FadeIn")
	await get_tree().create_timer(1.0).timeout
	queue_free()
	
# 淡出：从透明到黑（覆盖内容）
func FadeOut(duration: float = 0.5) -> void:
	$AnimationPlayer.play("FadeOut")

func FadeOutWithBack(callback: Callable, duration: float = 0.5) -> void:
	Rect.visible = true
	var tween = create_tween()
	tween.tween_property(Rect, "modulate:a", 1.0, duration)
	tween.connect("finished", callback)
