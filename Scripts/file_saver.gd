extends Node
@export var TargetDocumentName:String

func save_content(content):
	var file = FileAccess.open("user://"+TargetDocumentName, FileAccess.WRITE)
	file.store_string(content)
	file = null

func load_content():
	var file = FileAccess.open("user://"+TargetDocumentName, FileAccess.READ)
	if !file:
		return null
	var content = file.get_as_text()
	return content
