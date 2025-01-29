extends PanelContainer

# Button signals
signal planting(plant_id)
signal add_to_shop(plant_data, new_container)

var is_opened = false
var global_plant_profile = 0
@onready var farm_plants = $Panel/MarginContainer/VBoxContainer/FarmTileVBox/FarmTileHBox
@onready var vine_plants = $Panel/MarginContainer/VBoxContainer/VineTileVBox/VineTileHBox
@onready var tree_plants = $Panel/MarginContainer/VBoxContainer/TreeTileVBox/TreeTileHBox
@onready var water_plants = $Panel/MarginContainer/VBoxContainer/WaterTileVBox/WaterTileHBox


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass

func _on_parent_ready():
	create_plant_buttons()
	hide()

func create_plant_buttons():
	# Loop through plant profiles
	for plant_id in Global.plant_profiles.keys():
		if plant_id == 1:
			var plant_data = Global.plant_profiles[plant_id]
			var new_container = preload("res://scenes/universal_crop_button.tscn").instantiate()

			# Add container to correct row
			if plant_data["type"] == "farm":
				farm_plants.add_child(new_container)
			elif plant_data["type"] == "vine":
				vine_plants.add_child(new_container)
			elif plant_data["type"] == "tree":
				tree_plants.add_child(new_container)
			elif plant_data["type"] == "water":
				water_plants.add_child(new_container)

			print(plant_data)
			new_container.universal_label.text = plant_data["name"]
			new_container.universal_button.texture_normal = plant_data["texture"]
			new_container.plant_id = plant_id

			# Connect the button's signal
			new_container.connect("pressed_id", _on_plant_button_pressed)

		else:
			var plant_data = Global.plant_profiles[plant_id]
			var new_container = preload("res://scenes/universal_crop_button.tscn").instantiate()
			add_to_shop.emit(plant_data, new_container)

func create_plant_button(plant_id):
	var plant_data = Global.plant_profiles[plant_id]
	var new_container = preload("res://scenes/universal_crop_button.tscn").instantiate()

	# Add container to correct row
	if plant_data["type"] == "farm":
		farm_plants.add_child(new_container)
	elif plant_data["type"] == "vine":
		vine_plants.add_child(new_container)
	elif plant_data["type"] == "tree":
		tree_plants.add_child(new_container)
	elif plant_data["type"] == "water":
		water_plants.add_child(new_container)

	new_container.universal_label.text = plant_data["name"]
	new_container.universal_button.texture_normal = plant_data["texture"]
	new_container.plant_id = plant_id

	new_container.connect("pressed_id", _on_plant_button_pressed)

func _on_plant_button_pressed(plant_id):
	planting.emit(plant_id)
	Global.planting = true
	hide()

func _process(delta: float) -> void:
	if Input.is_action_just_pressed("seed_menu"):
		if is_opened == false:
			show()
			is_opened = true
		elif is_opened == true:
			hide()
			is_opened = false

	if Input.is_action_just_pressed("cancel"):
		if is_opened == true:
			hide()
			is_opened == false
