extends Node2D

@export var Root: DesktopIcon
@export var distance: float = 300
@export var speed: float = 100  # 每秒移动多少像素

var moving := false
var direction := -1  # -1 表示向左，1 表示向右
var start_x: float
var min_x: float
var max_x: float

var hero_original_parent: Node = null

func _ready() -> void:
	if Root:
		start_x = Root.position.x
		min_x = start_x - distance
		max_x = start_x + distance
		Root.HeroEnter.connect(HeroOnFloor)

func _process(delta: float) -> void:
	if not moving:
		return

	var pos = Root.position
	pos.x += direction * speed * delta
	Root.position = pos


func HeroOnFloor() -> void:
	print("HeroOnFloor")
	var hero = PlayerRegisterPoint.CurrentHero
	if not is_instance_valid(hero):
		return

	# 保存原始父节点
	if not hero_original_parent:
		hero_original_parent = hero.get_parent()
		hero_original_parent.remove_child(hero)

	# 保持全局位置不变地添加到平台
	var global_pos = hero.global_position
	Root.add_child(hero)
	hero.global_position = global_pos

	moving = true

func HeroLeaveFloor() -> void:
	print("HeroLeaveFloor")
	var hero = PlayerRegisterPoint.CurrentHero
	if not is_instance_valid(hero) or not hero_original_parent:
		return

	# 保持位置不变地还原到原来的父节点
	var global_pos = hero.global_position
	Root.remove_child(hero)
	hero_original_parent.add_child(hero)
	hero.global_position = global_pos

	moving = false
