extends Node2D
class_name DesktopIcon
@export var Name:String
signal HeroEnter
signal HeroWantToInteract
signal HeroLeave
func _ready() -> void:
	$"DetectPlayer-Layer1".body_entered.connect(DetectHero)
	ExLevelEntityM.Register(Name,self)
	
func Interact()->void:
	HeroWantToInteract.emit()

func DetectHero(body: Node2D) -> void:
	#print("DetectHero")
	HeroEnter.emit()

func FHeroLeave(body: Node2D) -> void:
	#print("FHeroLeave")
	HeroLeave.emit()
