extends CSGMesh3D

func _ready() -> void:
	new_island()

func new_island() -> void:
	randomize()
	
	var shader := material_override
	var noise = shader.get_shader_param("noise").noise
	noise.seed = randi()
	await get_tree().create_timer(.1).timeout
	shader.set_shader_param("height", randf_range(0.5, 1.25))
	await get_tree().create_timer(.1).timeout
	shader.set_shader_param("snowHeight", randf_range(0.5, 1.5))
	await get_tree().create_timer(.1).timeout
	shader.set_shader_param(
		"stoneHeight",
		shader.get_shader_param("snowHeight") + (randf_range(0.0, 3) * randf_range(.1, 1.0))
	)

func _input(event: InputEvent) -> void:
	if event.is_action_pressed("next_island"):
		new_island()
