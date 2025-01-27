extends StaticBody2D

var plant = Global.plant_selected
var plant_growing = false
var plant_grown = false
var crop_profile = Global.plant_data

func _process(delta: float) -> void:
	if plant_growing == false:
		plant = Global.plant_selected

func _on_area_2d_mouse_entered() -> void:
	if Global.planting == true:
		if not plant_growing:
			plant_growing = true
			plant = Global.plant_data.get("plant_id")
			$CropTimer.wait_time = Global.plant_data.get("growtime")
			$CropTimer.start()
			$Plant.play(Global.plant_data.get("animation"))

		else:
			print("plant is growing here already")

func _on_crop_timer_timeout() -> void:
	var growing_plant = $Plant
	if growing_plant.frame != 1:
		growing_plant.frame += 1
	else:
		growing_plant.frame = 2
		plant_grown = true

func _on_area_2d_input_event(viewport: Node, event: InputEvent, shape_idx: int) -> void:
	if Input.is_action_pressed("click"):
		if plant_grown:
			Global.plant_profiles[plant]["amount"] += 1
			plant_growing = false
			plant_grown = false
			$Plant.play("none")

		for plant_profile in Global.plant_profiles:
			print(Global.plant_profiles[plant_profile]["name"] + ": " + str(Global.plant_profiles[plant_profile]["amount"]))
