extends Node2D
class_name TransR
@export var Root: DesktopIcon
@export var TargetCollision:CollisionShape2D
@export var TargetEntity:DesktopIcon
var AlreadyChoosed:bool=false
var IfEnter:bool=false
func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(Choose)
	TargetEntity.DActivate()

func Choose()->void:
	pass
func DeleteSoftWare(nm:String)->void:
	print(nm)
	ExLevelEntityM.DesktopIconDic[nm].queue_free()

func MoveToGround() -> void:
	$"../../StaticBody2D/CollisionShape2D".disabled=false
	TweenMoveRootDown(3000, 10)  # 让 Root 向下移动 100 像素，动画持续 0.3 秒
	IfEnter=true
	
func _physics_process(delta: float) -> void:
	if IfEnter:
		PlayerRegisterPoint.CurrentHero.global_position=Root.global_position+Vector2(0,-200)
	
func TweenMoveRootDown(pixels: float = 50.0, duration: float = 0.2) -> void:
	if not Root:
		return
	TargetEntity.Activate()
	var tween := create_tween()
	var target_y := Root.position.y + pixels
	tween.tween_property(Root, "position:y", target_y, duration)
