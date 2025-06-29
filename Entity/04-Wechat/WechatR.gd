extends Node2D

@export var Root: DesktopIcon
@export var SketIns:SkectR

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(BeginChat)

func BeginChat()->void:
	var window:WeChatWindow=ExSceneManager.AddScene("res://Entity/04-Wechat/WechatWindow.tscn")
	window.Choose1s.connect(Choose.bind(1))
	window.Choose2s.connect(Choose.bind(2))

func Choose(seq:int)->void:
	match seq:
		1:
			SketIns.queue_free()
			$"../Wechat".play("1")
			$"../../05-Sketch/Ani".play("1")
			$"../AnimationPlayer".play("Die")
		2:
			$"../Wechat".play("2")
			$"../../05-Sketch/Ani".play("2")
	queue_free()
