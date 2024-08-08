extends CharacterBody2D

@onready var tilemap = $"../TileMap"
var current_path: Array[Vector2i] = []
var current_tile: Vector2i
var tile_speed: float = 0.0
var self_speed: float = 1.0

func _ready():
	if not tilemap:
		print("Error: TileMap not found")
	else:
		print("TileMap successfully loaded")

func _physics_process(delta):
	if current_path.is_empty():
		return

	var target_position = tilemap.map_to_local(current_path.front())
	update_tile_info(target_position)

	global_position = global_position.move_toward(target_position, self_speed * tile_speed * delta)
	
	if global_position == target_position:
		current_path.pop_front()

func _unhandled_input(event):
	if event.is_action_pressed("move_to"):
		var click_position = get_global_mouse_position()
		if tilemap and tilemap.is_point_walkable(click_position):
			current_path = tilemap.astar.get_id_path(
				tilemap.local_to_map(global_position),
				tilemap.local_to_map(click_position)
			).slice(1)

func update_tile_info(target_position):
	var new_tile = tilemap.local_to_map(target_position)
	if new_tile != current_tile:
		current_tile = new_tile
		tile_speed = tilemap.get_tile_speed(target_position)
