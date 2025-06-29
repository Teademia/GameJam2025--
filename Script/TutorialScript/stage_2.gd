extends StaticBody2D


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ExInteractiveManager.stageNode = self
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func move_platform() -> void:
	position.y -= ExInteractiveManager.platform_step

func activate_stage():
	var tween = create_tween()
	tween.tween_property($ColorRect, "scale", Vector2(1, 1), 1)
	await tween.finished

	#$AnimationPlayer.play("fullfill")
	#await $AnimationPlayer.animation_finished
