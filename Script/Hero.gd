extends CharacterBody2D
class_name Hero

@export var move_speed      : float = 400.0
@export var jump_velocity   : float = -800.0
@export var TrashBanPosition: DesktopIcon
@export var BiliEmiter      : Emiter
@export var xgrid           : int
@export var ygrid           : int

var GRAVITY : float = 1200
var velocity_y_pending := false

# 状态名
var CurrentState: String = "Idle"

# 输入变量
var input_dir: float = 0.0
var is_jump_pressed: bool = false
var AlreadyDeath:bool

func _ready() -> void:
	PlayerRegisterPoint.CurrentHero = self
	$Area2D.area_entered.connect(DeathByBullet)

	var cell_width: float = ExLevelEntityM.GridSize
	var cell_height: float = ExLevelEntityM.GridSize

func DeathByBullet(area: Area2D) -> void:
	if !AlreadyDeath:
		Death()
		AlreadyDeath=true

func Death() -> void:
	if !AlreadyDeath:
		change_state("Die")
		ExUManager.GameLose()
		ExMusicManager.PlaySFX("res://Music/Death/Death_SFX.wav")
		AlreadyDeath=true

func DeathToZero()->void:
	if !AlreadyDeath:
		change_state("Die")
		scale=Vector2(1,0.1)
		ExUManager.GameLose()
		AlreadyDeath=true
	
func _physics_process(delta: float) -> void:
	# === 输入采集 ===

	# 重力作用
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	# 下穿平台
	if Input.is_action_just_pressed("S"):
		$CollisionShape2D.disabled = true
		await get_tree().create_timer(0.5).timeout
		$CollisionShape2D.disabled = false

	# 状态驱动
	FindNextState()
	HandleState()

	# 翻转角色朝向
	if input_dir != 0:
		$Anis.flip_h = input_dir < 0

	# 应用移动
	move_and_slide()
	if global_position.y>3000:
		Death()
	if global_position.y<-2400 and is_on_floor():
		DeathToZero()

func FindNextState():
	input_dir = Input.get_action_strength("D") - Input.get_action_strength("A")
	is_jump_pressed = Input.is_action_just_pressed("W")
	if is_jump_pressed:
		print("JumpPressed")
		if is_on_floor():
			print("CanJump")
			ExMusicManager.PlaySFX("res://Music/Hit_SFX.wav")
	match CurrentState:
		"Idle":
			if is_jump_pressed and is_on_floor():
				change_state("Jump")
			elif abs(input_dir) > 0:
				change_state("Move")
		"Move":
			if is_jump_pressed and is_on_floor():
				change_state("Jump")
			elif abs(input_dir) == 0:
				change_state("Idle")
		"Jump":
			if is_on_floor():
				change_state("Idle")
		"RaisedByAir":
			if is_on_floor():
				change_state("Idle")
		"Die":
			pass  # 死亡不可跳出

func HandleState():
	match CurrentState:
		"Idle":
			velocity.x = 0
			if $Anis.animation != "Idle":
				$Anis.play("Idle")

		"Move":
			velocity.x = input_dir * move_speed
			if $Anis.animation != "Run":
				$Anis.play("Run")

		"Jump":
			velocity.x = input_dir * move_speed
			if $Anis.animation != "Jump-1":
				$Anis.play("Jump-1")

		"RaisedByAir":
			velocity.x = input_dir * move_speed
			if $Anis.animation != "Jump-2":
				$Anis.play("Jump-2")

		"Die":
			velocity.x = 0
			if $Anis.animation != "Die":
				$Anis.play("Die")

func change_state(new_state: String):
	if CurrentState == new_state:
		return
	CurrentState = new_state
	match new_state:
		"Idle":
			$Anis.play("Idle")
		"Move":
			$Anis.play("Move")
		"Jump":
			$Anis.play("Jump-1")
			velocity.y=jump_velocity
		"RaisedByAir":
			$Anis.play("Falling")
		"Die":
			$Anis.play("Death")
