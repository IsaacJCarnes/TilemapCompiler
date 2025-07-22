extends Node
@export var TargetDocumentName:String
signal has_loaded

var savedContent:String

func _ready():
	load_content()

func save_content(content:String):
	var file = FileAccess.open("user://"+TargetDocumentName, FileAccess.WRITE)
	file.store_string(content)
	file = null
	savedContent = content
	emit_signal("has_loaded")

func load_content():
	var file = FileAccess.open("user://"+TargetDocumentName, FileAccess.READ)
	if !file:
		return null
	var content = file.get_as_text()
	savedContent = content
	emit_signal("has_loaded")

func get_content():
	return str_to_var(savedContent)
