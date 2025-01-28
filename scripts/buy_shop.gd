extends StaticBody2D

signal buying

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_buy_zone_body_entered(body: Node2D) -> void:
	if body.has_method("can_buy"):
		buying.emit()
