extends VBoxContainer

signal pressed_id(plant_id)
@onready var universal_button: TextureButton = $UniversalButton
@onready var universal_label: Label = $UniversalLabel
@onready var plant_id = 0

func _on_universal_button_pressed() -> void:
	pressed_id.emit(plant_id)
