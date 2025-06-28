extends Node2D

@export var Root: DesktopIcon
@export var BulletScene: PackedScene
@export var shoot_interval := 0.1        # 发射间隔更快（如0.1秒一次）
@export var bullets_per_shot := 5        # 每次发射的音符数
@export var fire_direction := Vector2.DOWN  # 固定发射方向
@export var horizontal_spread := 100.0   # 横向发射范围（像素）
@export var is_looping := true

var shooting := false

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(ShootBegin)

func ShootBegin() -> void:
	if shooting:
		return
	shooting = true
	_shoot_bullets()  # 立即射一次
	if is_looping:
		var timer := Timer.new()
		timer.name = "ShootTimer"
		timer.wait_time = shoot_interval
		timer.autostart = true
		timer.one_shot = false
		timer.timeout.connect(_shoot_bullets)
		add_child(timer)

func _shoot_bullets() -> void:
	if not BulletScene:
		return
	var origin = Root.global_position

	for i in range(bullets_per_shot):
		# 在一定范围内横向分布音符
		var offset_x = lerp(-horizontal_spread / 2, horizontal_spread / 2, float(i) / max(bullets_per_shot - 1, 1))
		var bullet = BulletScene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = origin + Vector2(offset_x, 0)
		bullet.InitDirection = fire_direction.normalized()
		bullet.is_active = true
