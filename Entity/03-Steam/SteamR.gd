extends Node2D

@export var Root: DesktopIcon

func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(EmitSteam)

func EmitSteam() -> void:
	$"../Ani".play("Ready")
	await $"../Ani".animation_finished

	# 抖动效果（不使用相对偏移）
	var original_pos = Root.global_position
	var shake = create_tween()
	var shake_offset = 10.0
	var shake_duration = 0.05

	for i in range(3):
		shake.tween_property(Root, "global_position", original_pos + Vector2(0, -shake_offset), shake_duration)
		shake.tween_property(Root, "global_position", original_pos + Vector2(0, shake_offset), shake_duration)
	# 最后回到原位
	shake.tween_property(Root, "global_position", original_pos, shake_duration)
	
	await shake.finished
	ExMusicManager.PlaySFX("res://Music/Steam_SFX.wav")
	$"../Ani".play("Go")
	var nt = create_tween()
	nt.tween_property(Root, "global_position", global_position + Vector2(0, -1200), 2.0)
	nt.finished.connect(queue_free)
	nt.finished.connect(func():$"../Ani".play("Default"))
