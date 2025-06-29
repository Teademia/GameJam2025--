extends Node2D

@export var Root: DesktopIcon
@export var NextEntity:DesktopIcon

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(Transmit)

func Transmit()->void:
	ExMusicManager.PlaySFX("res://Music/Portal_SFX.wav")
	PlayerRegisterPoint.CurrentHero.global_position=NextEntity.global_position+Vector2(0,-200)
	PlayerRegisterPoint.CurrentHero.velocity=Vector2.ZERO
	$"../Ani".play("default")
	$"../../07-Edge/Ani".play("default")
