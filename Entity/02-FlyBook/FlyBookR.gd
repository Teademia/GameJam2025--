extends Node2D

@export var Root: DesktopIcon
@export var distance: float = 500
@export var speed: float = 100  # 每秒移动多少像素

var moving := false
var direction := -1  # -1 表示向左，1 表示向右
var start_x: float
var moved_distance: float = 0.0

var hero_original_parent: Node = null

func _ready() -> void:
	if Root:
		start_x = Root.position.x
		Root.HeroEnter.connect(HeroOnFloor)
		$"../DetectLeave".body_exited.connect(HeroLeaveFloor)
func _process(delta: float) -> void:
	if not moving:
		return

	var delta_x = direction * speed * delta
	var pos = Root.position
	pos.x += delta_x
	Root.position = pos
	PlayerRegisterPoint.CurrentHero.global_position.x+=delta_x

	moved_distance += abs(delta_x)
	
	# 如果移动总距离超出限制，就停下
	if moved_distance >= distance:
		HeroLeaveFloor(self)
		moving = false

func HeroOnFloor() -> void:
	moving=true
	
func HeroLeaveFloor(body:Node2D) -> void:
	moving=false
	
