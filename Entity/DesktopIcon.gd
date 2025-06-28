extends Node2D
class_name DesktopIcon
@export var Name:String
signal HeroEnter
signal HeroWantToInteract
signal HeroLeave

@export var xgrid:int
@export var ygrid:int
func _ready() -> void:
	$"DetectPlayer-Layer1".body_entered.connect(DetectHero)
	ExLevelEntityM.Register(Name, self)

	# 每个图标的格子尺寸（你可以调整）
	var cell_width: float = ExLevelEntityM.GridSize
	var cell_height: float =ExLevelEntityM.GridSize

	# 世界尺寸（右上为原点，需转换）
	var world_width: float =0
	var world_height: float =0

	# 计算实际位置
	var x = xgrid *cell_width
	var y = -ygrid * cell_height

	position = Vector2(x, y)

	
func Interact()->void:
	HeroWantToInteract.emit()

func DetectHero(body: Node2D) -> void:
	#print("DetectHero")
	HeroEnter.emit()

func FHeroLeave(body: Node2D) -> void:
	#print("FHeroLeave")
	HeroLeave.emit()
