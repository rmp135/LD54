class_name InventoryItem
extends Control

@export var hover_controller : HoverController

var is_selected: bool = false
var item : Item

var orig_position: Vector2 = Vector2(0,0)
var orig_size = Vector2(0,0)
var grab_offset = Vector2(0,0)

signal dropped(icon: InventoryItem)
signal on_hover(item: Item)
signal on_unhover()

func _enter_tree():
	($Icon as TextureRect).texture = item.texture
	position = Vector2(item.x * 32, item.y * 32)
	
func _process(delta):
	if is_selected:
		position = get_global_mouse_position() - get_parent().position - grab_offset
	pass

func _on_icon_gui_input(event: InputEvent):
	if event is InputEventMouseButton:
		is_selected = event.is_pressed()
		$AudioStreamPlayer.play()
		if event.is_pressed():
			grab_offset = event.position
			orig_position = position
			orig_size = Vector2(item.width, item.height)
			z_index = 99
			z_as_relative = false
			hover_controller.hide()
		if event.is_released():
			z_index = 0
			z_as_relative = true
			dropped.emit(self)

func _unhandled_key_input(event):
	if event as InputEventKey:
		if event.is_pressed() and is_selected and event.as_text_keycode() == "R":
			$AudioStreamPlayer.play()
			var tempWidth = item.width
			var fromRight = item.width * 32 - grab_offset.x
			var fromTop = grab_offset.y
			grab_offset.y = fromRight
			grab_offset.x = fromTop
			item.width = item.height
			item.height = tempWidth
			resize()
		
func resize():
	size.x = item.width * 32
	size.y = item.height * 32
	
func _on_icon_mouse_entered():
	on_hover.emit(item)

func _on_mouse_exited():
	if not is_selected:
		on_unhover.emit()

func set_item(itemIn: Item):
	item = itemIn
	resize()
