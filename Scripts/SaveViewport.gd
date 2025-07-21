extends Node
##Code from this forum

@export var viewport_path:NodePath
@export var tilePathsDocument:NodePath


@onready var target_viewport = get_node(viewport_path) if viewport_path else get_tree().root.get_viewport()


func save_to(path):
	var img = target_viewport.get_texture().get_data()
	img.flip_y()
	return img.save_png(path)
