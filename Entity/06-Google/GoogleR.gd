extends Node2D

@export var Root: DesktopIcon
@export var NextEntity:DesktopIcon

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(Transmit)

func Transmit()->void:
	PlayerRegisterPoint.CurrentHero.global_position=NextEntity.global_position+Vector2(0,-200)
	PlayerRegisterPoint.CurrentHero.velocity=Vector2.ZERO
