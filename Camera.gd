extends Node3D

var vel := 0.0

func _ready() -> void:
	Input.set_mouse_mode(Input.MOUSE_MODE_CAPTURED)

func _process(delta: float) -> void:
	rotate_y(vel)
	vel = lerp(vel, 0, 10 * delta)

func _input(event: InputEvent) -> void:
	if event is InputEventMouseMotion:
		vel += event.relative.x / 1000
	if event.is_action_pressed("ui_cancel"):
		get_tree().quit()
