extends Node2D

@export var Root: DesktopIcon

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(PlayerDeath)

func PlayerDeath()->void:
	PlayerRegisterPoint.CurrentHero.Death()
