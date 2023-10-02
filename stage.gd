extends Node

func set_enabled(enabled: bool):
	if enabled:
		$Sprite2D.show()
	else:
		$Sprite2D.hide()
