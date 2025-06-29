extends CanvasLayer

@onready var text_edit := $TextEdit
var is_updating := false

func _ready() -> void:
	text_edit.text_changed.connect(_on_text_changed)
	$Button.pressed.connect(Exit)
	
func _on_text_changed() -> void:
	if is_updating:
		return

	is_updating = true

	var count= text_edit.text.length()

	# 限制最大输入长度为 8
	if count > 8:
		count = 8
		text_edit.set_text(text_edit.get_text().substr(0, 8))

	# 构造掩码字符（圆圈）
	var masked := ""
	for i in count:
		masked += "•"

	text_edit.set_text(masked)

	is_updating = false

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("Enter"):
		ExSceneManager.ChangeSceneWithLoading("res://Levels/Level1.tscn")

func Exit() -> void:
	$Button.icon = load("res://Art/ButtonDown.png")  # 别忘了用 load() 加载资源
	await get_tree().create_timer(0.5).timeout
	$Button.icon = load("res://Art/Button.png")  # 别忘了用 load() 加载资源
	await get_tree().create_timer(0.5).timeout
	get_tree().quit()
