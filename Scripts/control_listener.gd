extends Node
@export var image_displayer:Node
@export var scaleScroll:HScrollBar
@export var scrollTarget:TextureRect
@export var refreshButton:Button
@export var colSetter:SpinBox

func _ready() -> void:
	scrollTarget.draw.connect(initScrollBar)
	refreshButton.pressed.connect(image_displayer.load_images)
	colSetter.set_value_no_signal(image_displayer.initColumns)
	colSetter.value_changed.connect(image_displayer.change_columns)

func initScrollBar():
	scrollTarget.draw.disconnect(initScrollBar)
	var minVal = min(scrollTarget.size.x, scrollTarget.size.y)
	scaleScroll.value = minVal
	scaleScroll.min_value = minVal
	scaleScroll.step = ceil(ceil(minVal)/100)
	changeScrollValue(minVal)
	scaleScroll.value_changed.connect(changeScrollValue)


func changeScrollValue(val: float):
	scrollTarget.custom_minimum_size = Vector2(val, val)
