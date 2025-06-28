extends Node2D
class_name QQGuide

@export var speed: float = 400.0
@export var wave_amplitude: float = 100.0     # 振幅：波动有多宽
@export var wave_frequency: float = 4.0      # 频率：波动有多快

var InitDirection: Vector2 = Vector2.ZERO
var is_active := false
var time_passed := 0.0

func _process(delta: float) -> void:
	if not is_active:
		return

	time_passed += delta

	# 主方向直线位移
	var forward_move = InitDirection * speed * delta

	# 在 InitDirection 垂直方向上增加正弦波偏移
	var perpendicular = InitDirection.rotated(PI / 2)
	var offset = perpendicular * sin(time_passed * wave_frequency) * wave_amplitude * delta

	position += forward_move + offset

	# 超出屏幕则销毁
	if not get_viewport_rect().has_point(global_position):
		queue_free()
