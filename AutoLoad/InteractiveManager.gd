extends Node

const platform_step = 51

var playerInput : RichTextLabel
var IconInput : RichTextLabel
var platformInput : RichTextLabel

enum status {
	BEGINNING,
	PLATFORM,
	GROUND,
}

var current_status = status.BEGINNING

var beginning_dialog_sequence = [
	#["player", "我在哪?"],
	["icon", "又是一个猝死的倒霉👻"],
	["icon", "那边那个，能看到我打字吗"],
	["player", "你是谁?"],
	["icon", "我是你爹"],
	["icon", "📎认识吧，他是我太奶"],
	["player", "..."],
	["icon", "闲话少说，别死😵我窗口里"],
	["icon", "跳上这个平台，然后赶紧滚出去"],
]

var platform_dialog_sequence = [
	#["player", "我在哪?"],
	["icon", ""],
	["icon", "111111111111111"],
	["icon", "222222222222222"],
	["icon", "333333333333333"],
	["icon", "444444444444444"],
	["icon", "555555555555555"],
]

var stageNode
var borderNode

#var dialog_sequence = [
	#["icon", "又一个倒霉鬼"],
	#["icon", "那边那个，能看到我打字吗"],
	#["player", "你是谁?"],
	#["icon", "我是你的工作好伙伴啊"],
	##["player", "小李吗？要数据不给数据源，让我从PDF里扣吗？"],
	#["player", "小李吗？"],
	#["icon", "竟然把我误认成无能的人类"],
	#["icon", "我可是本世纪以来最伟大的办公软件"],
	#["player", "。。。我在软件里？"],
	#["icon", "废话少说，别死我屏幕里"],
	#["icon", "赶紧从右上角的×出去"],
#]


var dialog_idx = 0
var platform_dialog_idx = 0
## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#

func handleDialog() -> void:
	if current_status == status.BEGINNING:
		if dialog_idx == len(beginning_dialog_sequence):
			enterPlatformStatus()
			return
		var dialog = beginning_dialog_sequence[dialog_idx]
		if dialog[0] == "player":
			playerInput.inputStart(dialog[1])
		elif dialog[0] == "icon":
			IconInput.inputStart(dialog[1])
			
	if current_status == status.PLATFORM:
		if platform_dialog_idx == len(platform_dialog_sequence):
			return
		var dialog = platform_dialog_sequence[platform_dialog_idx]
		if dialog[0] == "player":
			#playerInput.inputStart(dialog[1])
			pass
		elif dialog[0] == "icon":
			platformInput.inputStart(dialog[1])

func receive_stop_signal():
	dialog_idx += 1
	await get_tree().create_timer(0.5).timeout
	handleDialog()

func receive_platform_stop_signal():
	platform_dialog_idx += 1
	await get_tree().create_timer(0.5).timeout
	stageNode.move_platform()
	handleDialog()

func checkLoaded():
	if playerInput and IconInput:
		handleDialog()

func enterPlatformStatus():
	stageNode.move_platform()
	stageNode.activate_stage()
	current_status = status.PLATFORM
	
