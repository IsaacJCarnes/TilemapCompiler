extends VBoxContainer

@export var file_system:Node

var current_file_list:Array

func _ready():
	file_system.has_loaded.connect(create_labels)

func create_labels():
	for child in get_children():
		child.queue_free()
	var i:int = 0
	current_file_list = file_system.get_content()
	for filePath:String in current_file_list:
		var hSplit = HSplitContainer.new()
		hSplit.split_offset = 125
		hSplit.dragging_enabled = false
		
		var label = Label.new()
		label.text = filePath.get_slice("/", filePath.get_slice_count("/")-1)
		label.size_flags_horizontal = Control.SIZE_SHRINK_END
		
		var xButton = Button.new()
		xButton.text = "X"
		xButton.name = str(i)
		hSplit.add_child(label)
		hSplit.add_child(xButton)
		add_child(hSplit)
		xButton.pressed.connect(remove_item.bind(i))
		i = i+1

func remove_item(id):
	current_file_list.remove_at(id)
	file_system.save_content(current_file_list)
