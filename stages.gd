class_name Stages
extends Node2D

func set_stage(stage: int):
	$One.set_enabled(false)
	$Two.set_enabled(false)
	$Three.set_enabled(false)
	$Four.set_enabled(false)
	
	if stage >= 1:
		$One.set_enabled(true)
	if stage >= 2:
		$Two.set_enabled(true)
	if stage >= 3:
		$Three.set_enabled(true)
	if stage >= 4:
		$Four.set_enabled(true)
