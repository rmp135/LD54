class_name InventoryItem
extends TextureRect

var is_selected: bool = false
var item : Item

var orig_position: Vector2 = Vector2(0,0)

signal dropped(icon: InventoryItem)

# Called when the node enters the scene tree for the first time.
func _ready():
	resize()
	position = Vector2(item.x * 32, item.y * 32)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if is_selected:
		position = get_viewport().get_mouse_position() - get_parent().position - Vector2(1,1)
	pass

func _on_icon_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		is_selected = event.is_pressed()
		if event.is_pressed():
			orig_position = position
			z_index = 99
			z_as_relative = false
		if event.is_released():
			z_index = 0
			z_as_relative = true
			dropped.emit(self)
	if event is InputEventKey:
		print(event.as_text_keycode())

func _unhandled_key_input(event):
	if event as InputEventKey:
		if event.is_pressed() and is_selected and event.as_text_keycode() == "R":
			var w = item.width
			item.width = item.height
			item.height = w
			resize()
		
func resize():
	size.x = item.width * 32
	size.y = item.height * 32
