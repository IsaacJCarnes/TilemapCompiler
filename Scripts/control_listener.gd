extends Node
@export var image_displayer:Node
@export var scaleScroll:HScrollBar
@export var scrollTarget:TextureRect
@export var refreshButton:Button

func _ready() -> void:
	scrollTarget.draw.connect(initScrollBar)
	refreshButton.pressed.connect(image_displayer.load_images)

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
