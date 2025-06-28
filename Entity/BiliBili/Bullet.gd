extends Node2D
class_name Bullet

@export var speed: float = 400.0  # 子弹速度（像素/秒）
var InitDirection: Vector2 = Vector2.ZERO
var is_active := false

func _process(delta: float) -> void:
	if not is_active:
		return
	position += InitDirection * speed * delta

	# 可选：超出屏幕自动销毁
	if not get_viewport_rect().has_point(global_position):
		queue_free()
