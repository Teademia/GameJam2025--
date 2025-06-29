extends Node2D
class_name Emiter

@export var Root: Node2D
@export var BulletScene: PackedScene
var current_angle := 0.0
var shoot_timer: Timer

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(ShootBegin)

func ShootBegin() -> void:
	$"../Ani".play("Shoot")
	ExMusicManager.PlaySFX("res://Music/SFX/Wechat_SFX.wav")
	print("ShootBegin")
	if not BulletScene:
		print("NoBulletScene")
		return
	var bullet=BulletScene.instantiate()
	Root.add_child(bullet)  # 确保加到合适的父节点
	bullet.global_position = Root.global_position
	bullet.InitDirection =Vector2(1,0)
	await get_tree().create_timer(1.5).timeout
	$"../../04-Wechat/Wechat".play("2")
	
	var bullet2=BulletScene.instantiate()
	ExMusicManager.PlaySFX("res://Music/SFX/Wechat_SFX.wav")	
	Root.add_child(bullet2)  # 确保加到合适的父节点
	bullet2.ChangeText("我们腾讯才是最强的")
	bullet2.global_position = Root.global_position+Vector2(1000,0)
	bullet2.InitDirection =Vector2(-1,0)
	await get_tree().create_timer(1.5).timeout
	
	$"../Ani".play("Dead")
	ExMusicManager.PlaySFX("res://Music/SFX/Wechat_SFX.wav")
	var nt=create_tween()
	nt.tween_property(Root,"global_position",global_position+Vector2(-300,0),1)
	nt.tween_property(Root,"scale",Vector2(0,0),1)
	nt.finished.connect(Done)
	
func Done()->void:
	$"../../09-Trash/Trash".play("Half-Full")
	ExMusicManager.PlaySFX("res://Music/SFX/Trashbin_SFX.wav")
