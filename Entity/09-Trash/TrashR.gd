extends Node2D

@export var Root: Node2D
@export var BulletScene: PackedScene
@export var shoot_interval := 0.05       # 子弹发射频率（秒）
@export var bullet_spacing_angle_deg := 16  # 每发旋转角度（度）
var current_angle := 0.0
var shoot_timer: Timer

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(Choose)

func Choose()->void:
	var ins:TrashChooseWindow=ExSceneManager.AddScene("res://Entity/09-Trash/TrashChoose.tscn")
	ins.SoftWareDeleted.connect(DeleteSoftWare)

func DeleteSoftWare(nm:String)->void:
	print(nm)
	ExLevelEntityM.DesktopIconDic[nm].queue_free()
