extends PanelContainer

# Button signals
signal wheat_button_pressed
signal carrot_button_pressed
signal planting(plant_id)

var is_opened = false
var global_plant_profile = 0
@onready var farm_plants = $Panel/MarginContainer/VBoxContainer/FarmTileVBox/FarmTileHBox
@onready var vine_plants = $Panel/MarginContainer/VBoxContainer/VineTileVBox/VineTileHBox
@onready var tree_plants = $Panel/MarginContainer/VBoxContainer/TreeTileVBox/TreeTileHBox
@onready var water_plants = $Panel/MarginContainer/VBoxContainer/WaterTileVBox/WaterTileHBox
@onready var container = $Panel/MarginContainer/VBoxContainer/FarmTileVBox/FarmTileHBox/UniversalVBox
@onready var template_button = $Panel/MarginContainer/VBoxContainer/FarmTileVBox/FarmTileHBox/UniversalVBox/UniversalButton
@onready var template_label = $Panel/MarginContainer/VBoxContainer/FarmTileVBox/FarmTileHBox/UniversalVBox/UniversalLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	create_plant_buttons()
	hide()

func create_plant_buttons():
	# Loop through plant profiles
	for plant_id in Global.plant_profiles.keys():
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

		# Connect the button's signal
		new_container.connect("pressed_id", _on_plant_button_pressed)

	# Hide the template button and label
	template_button.hide()
	template_label.hide()
	container.hide()
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


func _on_wheat_button_pressed() -> void:
	Global.plant_selected = 1
	Global.planting = true
	wheat_button_pressed.emit()
	hide()

func _on_carrot_button_pressed() -> void:
	Global.plant_selected = 2
	Global.planting = true
	carrot_button_pressed.emit()
	hide()
