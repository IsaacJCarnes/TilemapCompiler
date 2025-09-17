extends Node
@export var image_displayer:Node
@export var scaleScroll:HScrollBar
@export var scrollTarget:TextureRect

func _ready() -> void:
	scrollTarget.draw.connect(initScrollBar)

func initScrollBar():
	scrollTarget.draw.disconnect(initScrollBar)
	var minVal = min(scrollTarget.size.x, scrollTarget.size.y)
	print("hi ", minVal)
	scaleScroll.value = minVal
	scaleScroll.min_value = minVal
	scaleScroll.step = ceil(ceil(minVal)/100)
	changeScrollValue(minVal)
	scaleScroll.value_changed.connect(changeScrollValue)

func changeScrollValue(val: float):
	scrollTarget.custom_minimum_size = Vector2(val, val)
