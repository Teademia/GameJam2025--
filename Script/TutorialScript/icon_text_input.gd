extends RichTextLabel

signal iconInputStop


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	ExInteractiveManager.IconInput = self
	ExInteractiveManager.checkLoaded()
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
	#if isProcessing and tween.finished:
		#var word = word_list[word_idx]
		#self.text = word[0]
		#var word_len = word[0].length()
		#tween.tween_property(self, "visible_characters", word_len, word_len * 0.3)
		#isProcessing = word[1]
		#if not isProcessing:
			#iconInputStop.emit()
		#word_idx += 1
		


func inputStart(text: String) -> void:
	self.visible_characters = 0
	self.text = text
	var word_len = text.length()
	var tween = create_tween()
	tween.tween_property(self, "visible_characters", word_len, word_len * 0.05)
	await tween.finished
	ExInteractiveManager.receive_stop_signal()
