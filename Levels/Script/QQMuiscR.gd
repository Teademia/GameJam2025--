extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$"..".HeroEnter.connect(PlayMusic)

func PlayMusic()->void:
	ExMusicManager.PlayMusicWithPath("res://Music/Level1/Level_2.wav")
	$"../AnimationPlayer".play("Begin")
