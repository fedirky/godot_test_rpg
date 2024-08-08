extends TileMap

var astar = AStarGrid2D.new()
var map_rect = Rect2i()

# Called when the node enters the scene tree for the first time.
func _ready():
	var tile_size = get_tileset().tile_size
	var tilemap_size = get_used_rect().end - get_used_rect().position
	map_rect = Rect2i(Vector2i(), tilemap_size)
	
	astar.region = map_rect
	astar.cell_size = tile_size
	astar.offset = tile_size * 0.5
	astar.default_compute_heuristic = AStarGrid2D.HEURISTIC_CHEBYSHEV
	astar.default_estimate_heuristic = AStarGrid2D.HEURISTIC_CHEBYSHEV
	astar.diagonal_mode = AStarGrid2D.DIAGONAL_MODE_AT_LEAST_ONE_WALKABLE
	astar.update()
	
	for i in tilemap_size.x:
		for j in tilemap_size.y:
			var coordinates = Vector2i(i, j)
			var tile_data = get_cell_tile_data(0, coordinates)
			if tile_data:
				if tile_data.get_custom_data('type') == "wall":
					astar.set_point_solid(coordinates)
				elif tile_data.get_custom_data('type') == "mud":
					astar.set_point_weight_scale(coordinates, 2.0)

func is_point_walkable(local_position):
	var map_position = local_to_map(local_position)
	if map_rect.has_point(map_position):
		return not astar.is_point_solid(map_position)
	return false

func get_tile_speed(local_position):
	var map_position = local_to_map(local_position)
	var tile_data = get_cell_tile_data(0, map_position)
	return tile_data.get_custom_data('speed')
