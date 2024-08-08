extends CharacterBody2D

@onready var tilemap = $"../TileMap"
var current_path: Array[Vector2i] = []
var current_tile: Vector2i
var tile_data:    TileData

var self_speed: float = 1.0

func _ready():
	if not tilemap:
		print("Error: TileMap not found")
	else:
		print("TileMap successfully loaded")
		current_tile = tilemap.local_to_map(position)
		tile_data = tilemap.get_cell_tile_data(0, current_tile)

func _physics_process(delta):
	if current_path.is_empty():
		return
	
	update_tile_info(position)
	var target_position = tilemap.map_to_local(current_path.front())
	global_position = global_position.move_toward(tilemap.map_to_local(current_path.front()), 
												  self_speed * tile_data.get_custom_data("speed") * delta)

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

func update_tile_info(character_position):
	var new_tile = tilemap.local_to_map(character_position)
	if current_tile != new_tile:
		current_tile = new_tile
		tile_data = tilemap.get_cell_tile_data(0, current_tile)
