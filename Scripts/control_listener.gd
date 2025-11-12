extends Node
@export var image_displayer:Node
@export var scaleScroll:HScrollBar
@export var scrollTarget:TextureRect
@export var refreshButton:Button
@export var colSetter:SpinBox
@export var rowSetter:SpinBox
@export var fileSystem:Node

func _ready() -> void:
	scrollTarget.draw.connect(initScrollBar)
	if(image_displayer.has_method("load_images")):
		refreshButton.pressed.connect(image_displayer.load_images)
	if(image_displayer.has_method("load_random_images")):
		refreshButton.pressed.connect(image_displayer.load_random_images)
	colSetter.value_changed.connect(image_displayer.change_columns)
	colSetter.value_changed.connect(fileSystem.save_blank_content)
	if rowSetter:
		rowSetter.value_changed.connect(image_displayer.change_rows)
		rowSetter.value_changed.connect(fileSystem.save_blank_content)

func initScrollBar():
	scrollTarget.draw.disconnect(initScrollBar)
	var minVal = min(scrollTarget.size.x, scrollTarget.size.y)
	scaleScroll.value = minVal
	scaleScroll.min_value = minVal
	scaleScroll.step = ceil(ceil(minVal)/100)
	changeScrollValue(minVal)
	scaleScroll.value_changed.connect(changeScrollValue)
	
	var tempCols = fileSystem.get_columns() if fileSystem.get_columns() != null else image_displayer.initColumns
	colSetter.set_value_no_signal(tempCols)

func changeScrollValue(val: float):
	scrollTarget.custom_minimum_size = Vector2(val, val)
