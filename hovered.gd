extends Control


# Called when the node enters the scene tree for the first time.
func _ready():
	hide()
	($Name as Label).text = "something"
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass

func on_hovered(item: Item):
	show()
	($Name as Label).text = item.name
	($Value as Label).text = var_to_str(item.value)

func on_unhovered():
	hide()
