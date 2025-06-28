extends Node2D

@export var Root: DesktopIcon
@export var Target: Node2D  # 目标节点
@export var speed: float = 300  # 每秒移动像素
@export var arrival_tolerance: float = 200  # 到达判定范围（像素）

var moving := false
var hero_original_parent: Node = null

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(HeroOnFloor)
		$"../DetectLeave".body_exited.connect(HeroLeaveFloor)

func _process(delta: float) -> void:
	if not moving or not is_instance_valid(Target):
		return

	var pos = Root.position
	var target_pos = Target.position
	var to_target = target_pos - pos
	var distance_to_move = speed * delta

	if to_target.length() <= arrival_tolerance:
		moving = false
		HeroLeaveFloor(self)
	else:
		var move_vector = to_target.normalized() * distance_to_move
		Root.position += move_vector
		PlayerRegisterPoint.CurrentHero.global_position.x += move_vector.x  # 同步主角位置

func HeroOnFloor() -> void:
	moving = true

func HeroLeaveFloor(body: Node2D) -> void:
	moving = false
