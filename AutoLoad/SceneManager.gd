extends Node

@onready var LevelChooseScenePath: String = "res://UI/LevelChoose/LevelChoose.tscn"
var LevelChooseSceneIns:Node
var LoadCache={}

var SettingNode:Node
var HandBookNode:Node
@onready var LoadingSceneIns:Loading=load("res://UI/Loading.tscn").instantiate()

func PreloadLevelChoose() -> void:
	var inst =LoadCache["res://UI/LevelChoose/LevelChoose.tscn"].instantiate
	LoadCache[LevelChooseScenePath] = inst

func ChangeSceneWithLoading(target_scene_path: String, para_array: Array = []) -> void:
	AddScene("res://UI/Loading.tscn")
	await get_tree().create_timer(1.0).timeout
	call_deferred("LoadSceneAsync", target_scene_path, para_array)

func LoadSceneAsync(scene_path: String, para_array: Array = []) -> void:
	print_debug("异步加载场景 " + scene_path)

	var loader = ResourceLoader.load_threaded_request(scene_path, "", true)
	if loader == null:
		push_error("无法加载场景资源：" + scene_path)
		return

	var StartTime = Time.get_ticks_msec()
	while ResourceLoader.load_threaded_get_status(scene_path) == ResourceLoader.THREAD_LOAD_IN_PROGRESS:
		var duration = (Time.get_ticks_msec() - StartTime) / 1000.0
		print("加载耗时: %s 秒" % duration)
		await get_tree().process_frame

	var status = ResourceLoader.load_threaded_get_status(scene_path)
	if status == ResourceLoader.THREAD_LOAD_LOADED:
		var packed_scene := ResourceLoader.load_threaded_get(scene_path)
		if packed_scene:
			var new_scene = packed_scene.instantiate()
			SwitchToSceneInstance(new_scene, para_array)
		else:
			push_error("PackedScene 无法实例化：" + scene_path)
	else:
		push_error("场景加载失败或被中断：" + scene_path)

func SwitchToSceneInstance(new_scene: Node, para_array: Array = []) -> void:
	var scene_tree = get_tree()
	var current_scene = scene_tree.current_scene

	scene_tree.root.remove_child(current_scene)
	if current_scene.scene_file_path != LevelChooseScenePath:
		current_scene.queue_free()
	else:
		LevelChooseSceneIns = current_scene

	scene_tree.root.add_child(new_scene)
	scene_tree.current_scene = new_scene

	# 如果新场景实现了 InitWithPara，就调用它
	if new_scene.has_method("InitWithPara"):
		new_scene.call("InitWithPara", para_array)

	# 添加加载动画
	var LoadIns: Loading = load("res://UI/Loading.tscn").instantiate()
	new_scene.add_child(LoadIns)
	LoadIns.FadeIn()

func Reload() -> void:
	var scene_tree = Engine.get_main_loop() as SceneTree
	var current_scene = scene_tree.current_scene
	if current_scene:
		var scene_path = current_scene.scene_file_path
		if scene_path != "":
			ChangeSceneWithLoading(scene_path)

func AddScene(scene_path: String, para_array: Array = []) -> Node:
	print_debug("添加子场景: " + scene_path)
	var scene_tree = Engine.get_main_loop() as SceneTree
	var scene_res = load(scene_path)
	if scene_res is PackedScene:
		print("SceneCreated")
		var curr = scene_tree.current_scene
		# 防止重复添加
		for child in curr.get_children():
			if "scene_file_path" in child and child.scene_file_path == scene_path:
				print_debug("Scene already added.")
				return child

		var new_scene = scene_res.instantiate()
		curr.add_child(new_scene)
		if new_scene.has_method("InitWithPara"):
			new_scene.call("InitWithPara", para_array)

		return new_scene
	else:
		print("Failed to load a valid scene from: " + scene_path)
		return null
