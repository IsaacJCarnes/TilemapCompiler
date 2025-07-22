@tool
extends Panel

@export var fileSystem:Node
@export var contentLoader:Panel

@onready var LoadFileDialog = $LoadFileDialog
@onready var LoadButton = $VBoxContainer/ButtonContainer/LoadButton
@onready var RegexValidator = RegEx.new()

# In this file, the word "silly" is used to make it obvious that the name is arbitrary.

#var silly_material_resource = preload("res://addons/material_creator/material_resource.gd")
var editor_interface: EditorInterface

var pathList: Array[String]

func _ready() -> void:
	print(OS.get_user_data_dir())
	LoadButton.pressed.connect(load_pressed)
	LoadFileDialog.files_selected.connect(load_file_selected)
	RenderingServer.canvas_item_set_clip(get_canvas_item(), true)
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
