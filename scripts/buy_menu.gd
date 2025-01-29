extends PanelContainer

var is_opened = false
signal create_bought_plant(plant_id)

@onready var farm_plants_shop = $Panel/MarginContainer/VBoxContainer/FarmTileVBox/FarmTileHBox
@onready var vine_plants_shop = $Panel/MarginContainer/VBoxContainer/VineTileVBox/VineTileHBox
@onready var tree_plants_shop = $Panel/MarginContainer/VBoxContainer/TreeTileVBox/TreeTileHBox
@onready var water_plants_shop = $Panel/MarginContainer/VBoxContainer/WaterTileVBox/WaterTileHBox
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cancel"):
		if is_opened == true:
			hide()

func _on_add_to_shop(plant_data, new_container):
	var plant_id = plant_data["plant_id"]

	# Add container to correct row
	if plant_data["type"] == "farm":
		farm_plants_shop.add_child(new_container)
	elif plant_data["type"] == "vine":
		vine_plants_shop.add_child(new_container)
	elif plant_data["type"] == "tree":
		tree_plants_shop.add_child(new_container)
	elif plant_data["type"] == "water":
		water_plants_shop.add_child(new_container)

	new_container.universal_label.text = plant_data["name"] + ": " + str(plant_data["buying price"])
	new_container.universal_button.texture_normal = plant_data["texture"]
	new_container.plant_id = plant_id

	# Connect the button's signal
	new_container.connect("pressed_id", _on_plant_bought)

	# Add button to group of buttons
	self.remove_from_group("buttons in shop")
	new_container.add_to_group("buttons in shop")


func _on_plant_bought(plant_id):
	if Global.money >= Global.plant_profiles[plant_id]["buying price"]:
		for button in get_tree().get_nodes_in_group("buttons in shop"):
			if button.plant_id == plant_id:
				Global.money -= Global.plant_profiles[plant_id]["buying price"]
				button.queue_free()
				create_bought_plant.emit(plant_id)
				audio_stream_player_2d.play()
