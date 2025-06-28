extends RichTextLabel

signal playerInputStop

# 0  means input, 1 means delete
var status = 0
var next_text = ""

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	self.visible_characters = 0
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("E"):
		if status == 0 and self.visible_characters != self.text.length():
			self.visible_characters += 1
			if self.visible_characters == self.text.length():
				playerInputStop.emit()
				
		elif status == 1 and self.visible_characters != 0:
			self.visible_characters -= 1
			if self.visible_characters == 0:
				status = 0
				self.text = next_text


func inputStart(text: String) -> void:
	if self.text:
		status = 1
		next_text = text
	else:
		status = 0
		self.text = text
