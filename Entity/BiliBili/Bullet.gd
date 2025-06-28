extends Node2D
class_name Bullet

@export var speed: float = 300.0  # 子弹速度（像素/秒）
var InitDirection: Vector2 = Vector2.ZERO
var is_active := false

func _ready() -> void:
	$BeingDetectByPlayer/CollisionShape2D.disabled=true
	await get_tree().create_timer(1.0).timeout
	$BeingDetectByPlayer/CollisionShape2D.disabled=false
	
func _process(delta: float) -> void:
	if not is_active:
		return
	position += InitDirection * speed * delta


func StaticEnter(body: Node2D) -> void:
	queue_free()
