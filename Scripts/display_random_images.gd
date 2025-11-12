extends GridContainer

@onready var parent:SubViewport = get_parent()
@export var file_system:Node

@export var tileXSize:int = 512
@export var tileYSize:int = 512

@export var currentScale:float = 0.25

@export var initColumns:float = 3

signal has_displayed_images

func _ready():
	scale =  Vector2(currentScale, currentScale)
	file_system.has_loaded.connect(load_random_images)

func change_columns(num: int):
	columns = num
	adjustParentSize();

var rows:int = 1:
	set(num):
		rows = num
		adjustParentSize()

func change_rows(num):
	rows = num

func load_random_images():
	for child in get_children():
		remove_child(child)
		child.queue_free()
	
	var filePaths = file_system.get_content()
	for i in range(columns):
		for x in range(rows):
			var image = Image.load_from_file(filePaths.pick_random())
			var texture = ImageTexture.create_from_image(image)
			var texRect:TextureRect = TextureRect.new()
			texRect.scale = Vector2(currentScale, currentScale)
			texRect.size = Vector2(tileXSize * currentScale, tileYSize * currentScale)
			texRect.texture = texture
			add_child(texRect)
		#print(filePath)
	adjustParentSize()
	has_displayed_images.emit()

func adjustParentSize():
	parent.size = Vector2(tileXSize * columns + 2, tileYSize * rows + 2)
