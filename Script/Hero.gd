extends CharacterBody2D
class_name Hero

## === 可在检视器里改的导出变量 ===
@export var move_speed      : float = 400.0   # 水平移动速度 (像素/秒)
@export var jump_velocity   : float = -800.0  # 起跳初始速度 (负值向上)
@export var TrashBanPosition:DesktopIcon
@export var BiliEmiter:Emiter

@export var xgrid:int
@export var ygrid:int
## === 内部常量 ===
# 使用项目设置里的全局重力；如果想手动设置，请改成固定数值
var GRAVITY : float = 1200
func _ready() -> void:
	PlayerRegisterPoint.CurrentHero=self
	$Area2D.area_entered.connect(DeathByBullet)

	# 每个图标的格子尺寸（你可以调整）
	var cell_width: float =ExLevelEntityM.GridSize
	var cell_height: float = ExLevelEntityM.GridSize

	# 世界尺寸（右上为原点，需转换）
	var world_width: float =0
	var world_height: float =0

	# 计算实际位置
	var x = xgrid *cell_width
	var y = -ygrid * cell_height

	position = Vector2(x, y)
func DeathByBullet(area:Area2D)->void:
	ExUManager.GameLose()
	
func Death()->void:
	ExUManager.GameLose()

func EnterNoMaskState()->void:
	$CollisionShape2D.disabled=true
	$Area2D/CollisionShape2D.disabled=true
	GRAVITY=0

func LeaveNoMaskState()->void:
	$CollisionShape2D.disabled=false
	$Area2D/CollisionShape2D.disabled=false
	GRAVITY=1200

func _physics_process(delta: float) -> void:
	### 1. 垂直方向：模拟重力
	if not is_on_floor():
		velocity.y += GRAVITY * delta


	### 2. 水平方向：读取 A/D（或 ←/→）
	var input_dir := Input.get_action_strength("D") - Input.get_action_strength("A")
	velocity.x = input_dir * move_speed
	if input_dir<0:
		$Anis.flip_h=true
	elif input_dir!=0:
		$Anis.flip_h=false

	### 3. 跳跃（可选）
	if Input.is_action_just_pressed("W") and is_on_floor():
		velocity.y = jump_velocity
		
	if Input.is_action_just_pressed("S"):
		$CollisionShape2D.disabled = true
		await get_tree().create_timer(0.5).timeout  # 0.3秒后恢复碰撞
		$CollisionShape2D.disabled = false

	### 4. 执行移动并自动处理碰撞
	move_and_slide()
	
	
