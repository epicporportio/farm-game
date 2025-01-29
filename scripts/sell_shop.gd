extends StaticBody2D

var sell_value = 0
var crop_amount = 0
var crop_price = 0
@onready var audio_stream_player_2d: AudioStreamPlayer2D = $AudioStreamPlayer2D

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_sell_zone_body_entered(body: Node2D) -> void:
	if body.has_method("can_sell"):
		for plant_profile in Global.plant_profiles:
			crop_amount = Global.plant_profiles[plant_profile]["amount"]
			crop_price = Global.plant_profiles[plant_profile]["price"]
			sell_value += crop_amount * crop_price
			Global.plant_profiles[plant_profile]["amount"] = 0
		Global.money += sell_value
		if sell_value > 0:
			audio_stream_player_2d.play()
		sell_value = 0
