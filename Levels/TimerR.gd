extends Node2D

@export var Root: DesktopIcon
var timer: Timer

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(HeroOnFloor)
	
	# 创建 Timer 实例
	timer = Timer.new()
	timer.wait_time = 5.0  # 可以根据需要调整初始等待时间
	timer.one_shot = true
	add_child(timer)
	
	timer.timeout.connect(Bomb)
	timer.stop()

func HeroOnFloor() -> void:
	print("HeroOnFloor")
	timer.start()

func Bomb() -> void:
	Root.queue_free()

func _process(delta: float) -> void:
	$CountDown.text = str(int(timer.time_left))
