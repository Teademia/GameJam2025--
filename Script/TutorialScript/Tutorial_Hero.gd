extends CharacterBody2D
class_name Tutorial_Hero


## === 可在检视器里改的导出变量 ===
@export var move_speed      : float = 400.0   # 水平移动速度 (像素/秒)
@export var jump_velocity   : float = -900.0  # 起跳初始速度 (负值向上)

## === 内部常量 ===
# 使用项目设置里的全局重力；如果想手动设置，请改成固定数值
var GRAVITY : float = ProjectSettings.get_setting("physics/2d/default_gravity")


#func _ready() -> void:

#
	#
	#if EXUManager.heroDupCount >= EXUManager.maxDupCount:
		#return 
#
	#var next = self.duplicate()
#
	#EXUManager.heroDupCount += 1
	#next.set_collision_layer_value(EXUManager.heroDupCount, false)
	#next.set_collision_mask_value(EXUManager.heroDupCount, false)
	#next.set_collision_layer_value(EXUManager.heroDupCount+1, true)
	#next.set_collision_mask_value(EXUManager.heroDupCount+1, true)
	#next.scale.x = 0.5509 ** (EXUManager.heroDupCount)
	#next.scale.y = 0.5509 ** (EXUManager.heroDupCount)
	##next.position.x = 938 * (0.5509 ** EXUManager.dupCount)
	##next.position.y = 457 * (0.5509 ** EXUManager.dupCount)
	##next.position.y = -326 ** (EXUManager.heroDupCount +1) + position.y
	#next.position.x = self.position.x + (411 - 20) * 0.5509 ** (EXUManager.heroDupCount)
	#next.position.y = self.position.y - 220 * 0.5509 ** (EXUManager.heroDupCount)
	#next.move_speed = move_speed * 0.5509
	#next.jump_velocity = jump_velocity * 0.5509
	#next.GRAVITY = GRAVITY * 0.5509
	#add_sibling.call_deferred(next)


func _physics_process(delta: float) -> void:
	
	### 1. 垂直方向：模拟重力
	if not is_on_floor():
		velocity.y += GRAVITY * delta

	if ExInteractiveManager.current_status != ExInteractiveManager.status.BEGINNING:

		
		### 2. 水平方向：读取 A/D（或 ←/→）
		var input_dir := Input.get_action_strength("D") - Input.get_action_strength("A")
		velocity.x = input_dir * move_speed

		### 3. 跳跃（可选）
		if Input.is_action_just_pressed("W") and is_on_floor():
			velocity.y = jump_velocity
		
		if Input.is_action_just_pressed(("S")):
			$CollisionShape2D.disabled = true
			await get_tree().create_timer(0.5).timeout  # 0.3秒后恢复碰撞
			$CollisionShape2D.disabled = false
	
	### 4. 执行移动并自动处理碰撞
	move_and_slide()


func _on_first_on_the_platform_body_entered(body: Node2D) -> void:
	$"../FirstOnThePlatform".queue_free()
	ExInteractiveManager.handleDialog()
