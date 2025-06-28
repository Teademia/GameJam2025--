extends Node2D
class_name SkectR
@export var Root: DesktopIcon

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(PlayerDeath)

func ChangeText(str:String)->void:
	$"../Text".text=str
	
func PlayerDeath()->void:
	PlayerRegisterPoint.CurrentHero.Death()
