extends Node2D

@export var Root: DesktopIcon
@export var BulletScene: PackedScene
@export var shoot_interval := 2.0       # 每轮间隔时间
@export var bullets_per_shot := 8       # 每轮子弹数量
@export var is_looping := true          # 是否持续发射

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
		var angle = TAU * i / bullets_per_shot
		var dir = Vector2.RIGHT.rotated(angle)

		var bullet = BulletScene.instantiate()
		get_parent().add_child(bullet)
		bullet.global_position = origin
		bullet.InitDirection = dir.normalized()
		bullet.is_active = true
