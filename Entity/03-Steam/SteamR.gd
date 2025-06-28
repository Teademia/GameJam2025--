extends Node2D

@export var Root: DesktopIcon

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(EmitSteam)

func EmitSteam()->void:
	PlayerRegisterPoint.CurrentHero.velocity.y=-800
	queue_free()
