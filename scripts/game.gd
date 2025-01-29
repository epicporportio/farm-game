extends Node2D

var is_planting = false
var selected_crop = 0 # 0 = none, 1 = wheat, 2 = carrot
@onready var money_label: Label = $CanvasLayer/Control/ColorRect/HBoxContainer/Label
@onready var buy_menu: PanelContainer = $Player/BuyMenu
@onready var seed_menu: PanelContainer = $Player/SeedMenu

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	seed_menu._on_parent_ready()

func _on_seed_menu_planting(plant_id: Variant) -> void:
	is_planting = true
	var crop_sprite = preload("res://scenes/crop_sprite.tscn").instantiate()
	Global.plant_data = Global.plant_profiles[plant_id]
	crop_sprite.texture = Global.plant_data["texture"]
	crop_sprite.scale = Vector2(1, 1)
	add_child(crop_sprite)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	money_label.text = "= " + str(Global.money)

func _on_buy_shop_buying() -> void:
	buy_menu.show()
	buy_menu.is_opened = true

func _on_seed_menu_add_to_shop(plant_data: Variant, new_container: Variant) -> void:
	buy_menu._on_add_to_shop(plant_data, new_container)

func _on_buy_menu_create_bought_plant(plant_id: Variant) -> void:
	seed_menu.create_plant_button(plant_id)
