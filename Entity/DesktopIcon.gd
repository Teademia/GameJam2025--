extends Node2D
class_name DesktopIcon

signal HeroEnter
signal HeroWantToInteract

func _ready() -> void:
	$"DetectPlayer-Layer1".body_entered.connect(DetectHero)
	
func Interact()->void:
	HeroWantToInteract.emit()

func DetectHero(body: Node2D) -> void:
	print("HeroEnterDetct")
	HeroEnter.emit()
