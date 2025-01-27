extends Node2D

var is_planting = false
var selected_crop = 0 # 0 = none, 1 = wheat, 2 = carrot


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_seed_menu_planting(plant_id: Variant) -> void:
	is_planting = true
	var crop_sprite = preload("res://scenes/crop_sprite.tscn").instantiate()
	Global.plant_data = Global.plant_profiles[plant_id]
	crop_sprite.texture = Global.plant_data["texture"]
	crop_sprite.scale = Vector2(1, 1)
	add_child(crop_sprite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass
