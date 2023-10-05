extends Node2D

@export var scenarios : Array[Scenario]

var stage = 0
var timer = 10

var otherInventory : Inventory
var myInventory : Inventory

func _ready():
	otherInventory = $InventoryManager/OtherInventory
	myInventory = $InventoryManager/MyInventory
	progress_stage()

func progress_stage():
	timer = 10
	$Timer.stop()
	$Stages/NinePatchRect4.hide()
	stage = stage + 1
	var inventoryManager = $InventoryManager as InventoryManager
	otherInventory.clear_items()
	if stage < 5:
		var scenario = pick_scenario()
		if not scenario.prevent_countdown:
			$Stages/NinePatchRect4.show()
			($Stages/NinePatchRect4/MoveOnLabel as Label).text = "Moving on in 10"
		#	$Timer.start()
			
		inventoryManager.generate_inventory(scenario)
		($Stages as Stages).set_stage(stage)
	#	($InventoryManager/NinePatchRect2/TitleLabel as Label).text = scenario.name
	#	($InventoryManager/NinePatchRect2/DescriptionLabel as Label).text = scenario.description
	if stage == 5:
		end_game()

func pick_scenario() -> Scenario:
	#var restScenario = scenarios.filter(is_rest_scenario).pick_random()
	##if stage == 3:
	#	return restScenario
	return scenarios.pick_random()

func is_rest_scenario(s: Scenario):
	return s.prevent_countdown

func end_game():
	$RestartButton.show()
	$GameOver.show()
	$TextureButton.hide()
	$Stages/NinePatchRect4.hide()
	$Timer.stop()
	var total = 0
	var children = myInventory.get_children() as Array[InventoryItem]
	for c in children:
		total = total + c.item.value
	$GameOver/Value.text = var_to_str(total)
	

func _on_texture_button_pressed():
	$ClickAudioPlayer.play()
	progress_stage()

func _on_restart_button_pressed():
	$ClickAudioPlayer.play()
	stage = 0
	myInventory.clear_items()
	progress_stage()
	$TextureButton.show()
	$RestartButton.hide()
	$GameOver.hide()
	$Stages/NinePatchRect4.show()
	$Timer.start()

func _on_timer_timeout():
	timer = timer - 1
	if timer == 0:
		progress_stage()
	else:
		($Stages/NinePatchRect4/MoveOnLabel as Label).text = "Moving on in %s" % timer
