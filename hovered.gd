class_name HoverController
extends Control

@export var name_label : Label
@export var value_label : Label

# Called when the node enters the scene tree for the first time.
func _ready():
	hide()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var mouse_pos = get_global_mouse_position() + Vector2(10,10)
	position = mouse_pos

func on_hovered(item: Item):
	show()
	name_label.text = item.name
	value_label.text = str(item.value)

func on_unhovered():
	hide()
