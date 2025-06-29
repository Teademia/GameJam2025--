extends Node2D
@export var Root: Node2D

var count:int=0
func _ready() -> void:
	if Root:
		Root.HeroEnter.connect(AddNote)

func AddNote()->void:
	count+=1
	if count>1:
		var ins=ExSceneManager.AddScene("res://Entity/11-NoteBook/NoteBookChoose.tscn")
		queue_free()
