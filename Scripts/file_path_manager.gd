@tool
extends Panel

@export var fileSystem:Node

@onready var LoadFileDialog = $LoadFileDialog
@onready var RegexValidator = RegEx.new()

# In this file, the word "silly" is used to make it obvious that the name is arbitrary.

#var silly_material_resource = preload("res://addons/material_creator/material_resource.gd")
var editor_interface: EditorInterface

var pathList: Array[String]


func _ready() -> void:
	$VBoxContainer/LoadButton.pressed.connect(load_pressed)
	LoadFileDialog.files_selected.connect(load_file_selected)
	RenderingServer.canvas_item_set_clip(get_canvas_item(), true)
	RegexValidator.compile('^.*\\.(jpg|png|jpeg)$')
	if fileSystem.load_content():
		pathList.assign(str_to_var(fileSystem.load_content()))
		print(pathList)

func load_pressed() -> void:
	LoadFileDialog.popup_centered_ratio()


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
