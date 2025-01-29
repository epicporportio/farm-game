extends StaticBody2D

var plant = Global.plant_selected
var plant_growing = false
var plant_grown = false
var crop_profile = Global.plant_data
var plant_type = Global.plant_data
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D
@onready var audio_stream_player_2d_2: AudioStreamPlayer2D = $AudioStreamPlayer2D2

func _process(delta: float) -> void:
	if plant_growing == false:
		plant = Global.plant_selected

func _on_area_2d_mouse_entered() -> void:
	if Global.planting == true:
		if not plant_growing:
			plant_type = Global.plant_data.get("type")
			if plant_type == "vine":
				plant_growing = true
				plant = Global.plant_data.get("plant_id")
				$CropTimer.wait_time = Global.plant_data.get("growtime")
				$CropTimer.start()
				$Plant.play(Global.plant_data.get("animation"))
				audio_stream_player_2d.pitch_scale = randf_range(0.8,1.2)
				audio_stream_player_2d.play()

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
			Global.plant_profiles[plant]["amount"] += Global.plant_profiles[plant]["amount per harvest"]
			plant_growing = false
			plant_grown = false
			$Plant.play("none")
			audio_stream_player_2d_2.pitch_scale = randf_range(0.8, 1.2)
			audio_stream_player_2d_2.play()

		for plant_profile in Global.plant_profiles:
			print(Global.plant_profiles[plant_profile]["name"] + ": " + str(Global.plant_profiles[plant_profile]["amount"]))
