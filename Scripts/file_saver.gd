extends Node
@export var TargetDocumentName:String
@export var gridItem:GridContainer
@onready var filePath = "user://"+TargetDocumentName
signal has_loaded

var savedContent:Dictionary

func _ready():
	load_content()

func save_content(content=savedContent.get("content")):
	var file = get_file(FileAccess.WRITE)
	file.store_string(var_to_str({"content":content,"columns":gridItem.columns}))
	file = null
	savedContent = {"content":content,"columns":gridItem.columns}
	emit_signal("has_loaded")

func save_blank_content(blank):
	save_content()

func load_content():
	var file = get_file(FileAccess.READ)
	if !file:
		return null
	var content = file.get_as_text()
	savedContent = str_to_var(content)
	if(savedContent.get("columns") != null):
		gridItem.change_columns(savedContent.get("columns"))
	emit_signal("has_loaded")

func get_content():
	return savedContent.get("content") if savedContent.get("content") != null else []

func get_columns():
	return savedContent.get("columns")

func get_file(accessLevel:FileAccess.ModeFlags) -> FileAccess:
	var file = FileAccess.open(filePath, accessLevel)
	return file
	
