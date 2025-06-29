extends Node2D
class_name Bullet

@export var speed: float = 300.0  # 子弹速度（像素/秒）
var InitDirection: Vector2 = Vector2.ZERO

func _ready() -> void:
	$Timer.timeout.connect(queue_free)
	$Timer.timeout.connect(func():print("子弹结束"))

func ChangeText(str1:String)->void:
	$Shooter.text=str1
	$Wechat.visible=true

func _process(delta: float) -> void:
	position += InitDirection * speed * delta
