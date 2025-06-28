extends Node

@export var playerInput : RichTextLabel
@export var IconInput : RichTextLabel

var dialog_sequence = [
	["player", "我在哪?"],
	["icon", "又是一个猝死的倒霉👻"],
	["icon", "那边那个，能看到我打字吗"],
	["player", "你是谁?"],
	["icon", "📎认识吧，他是我太奶"],
	["icon", "闲话少说，别死😵我窗口里"],
	["icon", "跳上这个平台，然后赶紧滚出去"],
	["player", "..."],
]
var dialog_idx = 0

## Called when the node enters the scene tree for the first time.
func _ready() -> void:
	handleDialog()
	pass # Replace with function body.


#
## Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta: float) -> void:
	#pass
#

func handleDialog() -> void:
	var dialog = dialog_sequence[dialog_idx]
	print(dialog)
	if dialog[0] == "player":
		playerInput.inputStart(dialog[1])
	elif dialog[0] == "icon":
		IconInput.inputStart(dialog[1])

func receive_stop_signal():
	dialog_idx += 1
	await get_tree().create_timer(0.5).timeout
	handleDialog()
