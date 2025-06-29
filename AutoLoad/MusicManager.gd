extends Node

var BGM_Player: AudioStreamPlayer
var SFX_Player: AudioStreamPlayer

var FadeDuration: float = 1.0  # 淡入/淡出时间
var CurrentPath:String="res://BeginMusic.mp3"
func _ready() -> void:
	process_mode = PROCESS_MODE_ALWAYS
	BGM_Player = AudioStreamPlayer.new()
	BGM_Player.name = "BGM_Player"
	BGM_Player.bus = "BGM"
	BGM_Player.finished.connect(Callable(self,"LoopMusic"))
	add_child(BGM_Player)

	SFX_Player = AudioStreamPlayer.new()
	SFX_Player.name = "SFX_Player"
	SFX_Player.bus = "SFX"
	add_child(SFX_Player)

# 淡出旧 BGM 并淡入新音乐
func PlayMusicWithPath(path: String) -> void:
	SpeedUpBGM(1.0)
	CurrentPath=path
	if BGM_Player.playing:
		# 创建淡出当前音乐的 tween
		var fade_out_tween := get_tree().create_tween()
		fade_out_tween.tween_property(BGM_Player, "volume_db", -40, FadeDuration)
		await fade_out_tween.finished

	BGM_Player.stream = load(path)
	BGM_Player.volume_db = -40  # 初始音量较低
	BGM_Player.play()

	# 创建淡入新音乐的 tween
	var fade_in_tween := get_tree().create_tween()
	fade_in_tween.tween_property(BGM_Player, "volume_db", 0, FadeDuration)

func LoopMusic()->void:
	BGM_Player.stream = load(CurrentPath)
	BGM_Player.volume_db = -40  # 初始音量较低
	BGM_Player.play()

	# 创建淡入新音乐的 tween
	var fade_in_tween := get_tree().create_tween()
	fade_in_tween.tween_property(BGM_Player, "volume_db", 0, FadeDuration)

# 播放音效
func PlaySFX(path: String) -> void:
	#print_debug(path)
	var player := AudioStreamPlayer.new()
	player.stream = load(path)
	player.bus = "SFX"
	add_child(player)
	player.play()

	# 连接 finished 信号以自动移除节点
	player.finished.connect(func():
		player.queue_free()
	)

func PlaySFXAwait(path: String) -> void:
	var player := AudioStreamPlayer.new()
	player.stream = load(path)
	player.bus = "SFX"
	add_child(player)

	# 等待播放完毕
	var finished_signal = player.finished
	player.play()
	await finished_signal

	player.queue_free()

func FadeAllSFX() -> void:
	for child in get_children():
		if child is AudioStreamPlayer and child.bus == "SFX" and child.playing:
			var tween := get_tree().create_tween()
			tween.tween_property(child, "volume_db", -40, FadeDuration)
			tween.tween_callback(Callable(child, "stop"))
			tween.tween_callback(Callable(child, "queue_free"))

func FadeCurrent()->void:
	if BGM_Player.playing:
		# 创建淡出当前音乐的 tween
		var fade_out_tween := get_tree().create_tween()
		fade_out_tween.tween_property(BGM_Player, "volume_db", -40, FadeDuration)
		await fade_out_tween.finished

func SpeedUpBGM(sp:float)->void:
	BGM_Player.pitch_scale=sp

func MouseHover()->void:
	PlaySFX("res://Music/主界面/UI悬停v1.ogg")

func MousePressed()->void:
	PlaySFX("res://Music/主界面/UI点击.ogg")
