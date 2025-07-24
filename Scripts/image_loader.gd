extends Node

@export var fileSystem:Node
@export var LoadFileDialog:FileDialog
@export var LoadButton:Button

@onready var parent = get_parent()
@onready var RegexValidator = RegEx.new()

var editor_interface: EditorInterface

var pathList: Array[String]

func _ready() -> void:
	print(OS.get_user_data_dir())
	LoadButton.pressed.connect(load_pressed)
	LoadFileDialog.files_selected.connect(load_file_selected)
	RenderingServer.canvas_item_set_clip(parent.get_canvas_item(), true)
	RegexValidator.compile('^.*\\.(jpg|png|jpeg)$')
	fileSystem.has_loaded.connect(assign_pathlist)

func load_pressed() -> void:
	LoadFileDialog.popup_centered_ratio()

func assign_pathlist():
	pathList.assign(fileSystem.get_content())


func load_file_selected(paths: PackedStringArray) -> bool:
	for path in paths:
		if  pathList.count(path) != 0:
			continue
		if !FileAccess.file_exists(path):
			continue
		var is_image = RegexValidator.search(path)
		if is_image == null:
			printerr(path, " is not an image")
			continue
		pathList.append(path)
	fileSystem.save_content(var_to_str(pathList))
	return true
