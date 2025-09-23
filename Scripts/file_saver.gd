extends Node
@export var TargetDocumentName:String
@onready var filePath = "user://"+TargetDocumentName
signal has_loaded

var savedContent:String

func _ready():
	load_content()

func save_content(content:String):
	EditorInterface.get_resource_filesystem().update_file(filePath)
	var file = get_file(FileAccess.WRITE)
	file.store_string(content)
	file = null
	savedContent = content
	emit_signal("has_loaded")

func load_content():
	var file = get_file(FileAccess.READ)
	if !file:
		return null
	var content = file.get_as_text()
	savedContent = content
	emit_signal("has_loaded")

func get_content():
	return str_to_var(savedContent)

func get_file(accessLevel:FileAccess.ModeFlags) -> FileAccess:
	var file = FileAccess.open(filePath, accessLevel)
	return file
	
