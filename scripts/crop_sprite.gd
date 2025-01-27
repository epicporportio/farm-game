extends Sprite2D

func _ready() -> void:
	Global.planting = true

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("cancel") or Input.is_action_just_pressed("seed_menu"):
		Global.planting = false
		queue_free()
	global_position = get_global_mouse_position()
