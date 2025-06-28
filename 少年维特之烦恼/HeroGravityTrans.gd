extends CharacterBody2D
class_name HeroG

## === 可在检视器里改的导出变量 ===
@export var move_speed      : float = 400.0   # 水平移动速度 (像素/秒)
@export var jump_velocity   : float = -800.0  # 起跳初始速度 (负值向上)

#-1 代表向上，1代表向下
var GravityUpOrDown:int=-1
## === 内部常量 ===
# 使用项目设置里的全局重力；如果想手动设置，请改成固定数值
var GRAVITY : float = ProjectSettings.get_setting("physics/2d/default_gravity")




func _physics_process(delta: float) -> void:
	### 1. 垂直方向：模拟重力
	if not is_on_floor():
		velocity.y += GRAVITY * delta*GravityUpOrDown

	if not is_on_ceiling():
		print("IsOnCeiling")
		velocity.y += GRAVITY * delta*GravityUpOrDown
	else:
		print("OnCeiling MoveStop")

	### 2. 水平方向：读取 A/D（或 ←/→）
	var input_dir := Input.get_action_strength("D") - Input.get_action_strength("A")
	velocity.x = input_dir * move_speed

	### 3. 跳跃（可选）
	if Input.is_action_just_pressed("W") and is_on_floor():
		velocity.y = jump_velocity
	
	if Input.is_action_just_pressed("S") and is_on_ceiling():
		velocity.y = -jump_velocity
	
	### 4. 执行移动并自动处理碰撞
	move_and_slide()
