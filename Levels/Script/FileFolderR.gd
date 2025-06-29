extends Node2D

@export var Root: DesktopIcon
@export var TransRIns:TransR
var count: int = 4

var animating := false
var time_passed=0.0
var Activated:bool=false
func _ready() -> void:
	if Root:
		print("RootIsOK")
		Root.HeroEnter.connect(TryGoDown)
	$"../Count".text = str(count)

func Activate()->void:
	$"../Count".visible=true
	Activated=true
	
func TryGoDown() -> void:
	if !Activated:
		return
	print("Try")
	count -= 1
	$"../Count".text = str(count)
	if count <= 0:
		animating = true

func _process(delta: float) -> void:
	if count<=0:
		Root.global_position.y+=10
		time_passed+=delta
		if time_passed>0.5:
			ExMusicManager.PlaySFX("res://Music/SFX/Trashbin_SFX.wav")
			TransRIns.MoveToGround()
			Root.queue_free()
			$"../../09-Trash/Trash".play("Full")
