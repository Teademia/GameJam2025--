extends Node2D
class_name Emiter

@export var Root: Node2D
@export var BulletScene: PackedScene
@export var shoot_interval := 0.01       # 子弹发射频率（秒）
@export var bullet_spacing_angle_deg := 17  # 每发旋转角度（度）
@export var is_looping := true                # 是否持续发射

var shooting := false
var current_angle := 0.0
var shoot_timer: Timer

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(ShootBegin)

func ShootBegin() -> void:
	if shooting:
		return
	shooting = true

	# 立即发射一颗
	_shoot_bullets()
	if is_looping:
		# 创建并配置计时器
		shoot_timer = Timer.new()
		shoot_timer.wait_time = shoot_interval
		shoot_timer.one_shot = false
		shoot_timer.autostart = true
		shoot_timer.timeout.connect(_shoot_bullets)
		add_child(shoot_timer)

func _shoot_bullets() -> void:
	if not BulletScene:
		return
	var angle_rad = current_angle * PI / 180.0
	var dir = Vector2.RIGHT.rotated(angle_rad)

	var bullet = BulletScene.instantiate()
	add_child(bullet)
	bullet.global_position = global_position
	bullet.InitDirection = dir.normalized()
	bullet.is_active = true

	current_angle += bullet_spacing_angle_deg
	if current_angle >= 360.0:
		current_angle -= 360.0

func StopAndClearBullet() -> void:
	if shoot_timer:
		shoot_timer.stop()
		shoot_timer.queue_free()
		shoot_timer = null
	shooting = false

	for child in get_children():
		child.queue_free()
