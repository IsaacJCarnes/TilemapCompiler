extends Node

@export var ExportFileDialog:FileDialog
@export var ExportButton:Button
@export var TargetViewport:SubViewport

@onready var parent = get_parent()

var editor_interface: EditorInterface

var pathList: Array[String]

func _ready() -> void:
	print(OS.get_user_data_dir())
	ExportButton.pressed.connect(export_pressed)
	ExportFileDialog.file_selected.connect(export_file_selected)
	RenderingServer.canvas_item_set_clip(parent.get_canvas_item(), true)

func export_pressed() -> void:
	ExportFileDialog.popup_centered_ratio()

func export_file_selected(path: String) -> bool:
	var img = TargetViewport.get_texture().get_image()
	#img.flip_y()
	return img.save_png(path)
