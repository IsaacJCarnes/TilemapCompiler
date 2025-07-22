extends Panel

@export var file_system:Node

@export var tileXSize:int = 512
@export var tileYZSize:int = 512

@export var currentScale:float = 0.25

@onready var grid = $GridContainer

func _ready():
	grid.scale =  Vector2(currentScale, currentScale)
	file_system.has_loaded.connect(load_images)

func load_images():
	for child in grid.get_children():
		child.queue_free()
	
	for filePath in file_system.get_content():
		var image = Image.load_from_file(filePath)
		var texture = ImageTexture.create_from_image(image)
		var texRect:TextureRect = TextureRect.new()
		texRect.scale = Vector2(currentScale, currentScale)
		texRect.size = Vector2(tileXSize * currentScale, tileYZSize * currentScale)
		texRect.texture = texture
		grid.add_child(texRect)
		print(filePath)
