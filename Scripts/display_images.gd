extends GridContainer

@onready var parent:SubViewport = get_parent()
@export var file_system:Node

@export var tileXSize:int = 512
@export var tileYSize:int = 512

@export var currentScale:float = 0.25

@export var initColumns:float = 3

signal has_displayed_images

func _ready():
	columns = initColumns
	scale =  Vector2(currentScale, currentScale)
	file_system.has_loaded.connect(load_images)

func change_columns(num: int):
	columns = num
	var rows = ceil(get_children().size() / columns)
	parent.size = Vector2(tileXSize * columns, tileYSize * rows)

func load_images():
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	for filePath in file_system.get_content():
		var image = Image.load_from_file(filePath)
		var texture = ImageTexture.create_from_image(image)
		var texRect:TextureRect = TextureRect.new()
		texRect.scale = Vector2(currentScale, currentScale)
		texRect.size = Vector2(tileXSize * currentScale, tileYSize * currentScale)
		texRect.texture = texture
		add_child(texRect)
		print(filePath)
	var rows = ceil(get_children().size() / columns)
	parent.size = Vector2(tileXSize * columns, tileYSize * rows)
	has_displayed_images.emit()
	print(rows)
