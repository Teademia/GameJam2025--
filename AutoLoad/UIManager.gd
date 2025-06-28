extends Node


@onready var GameWinScenePath:String="res://UI/GameWinUI.tscn"

func GameWin()->void:
	var CurrentScene=get_tree().current_scene
	CurrentScene.add_child(load(GameWinScenePath).instantiate())
