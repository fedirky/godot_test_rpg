extends Camera2D

var threshold_screen_edge = 20
var speed_max = 256

var left_limit
var top_limit
var right_limit
var bottom_limit

func _ready():
	var limits = $"../TileMap".map_limits
	left_limit = limits[0]
	top_limit = limits[1]
	right_limit = limits[2]
	bottom_limit = limits[3]

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var viewport_size = get_viewport().size
	var move_vector = Vector2()

	if mouse_pos.x < threshold_screen_edge:
		move_vector.x = -lerp(0, speed_max, 1 - mouse_pos.x / threshold_screen_edge)
	elif mouse_pos.x > viewport_size.x - threshold_screen_edge:
		move_vector.x = lerp(0, speed_max, (mouse_pos.x - (viewport_size.x - threshold_screen_edge)) / threshold_screen_edge)

	if mouse_pos.y < threshold_screen_edge:
		move_vector.y = -lerp(0, speed_max, 1 - mouse_pos.y / threshold_screen_edge)
	elif mouse_pos.y > viewport_size.y - threshold_screen_edge:
		move_vector.y = lerp(0, speed_max, (mouse_pos.y - (viewport_size.y - threshold_screen_edge)) / threshold_screen_edge)

	global_position += move_vector * delta

	# Ensure camera stays within limits
	global_position.x = clamp(global_position.x, left_limit, right_limit)
	global_position.y = clamp(global_position.y, top_limit, bottom_limit)


'''
extends Camera2D

var dragging = false
var last_mouse_position = Vector2()

func _input(event):
	if event is InputEventMouseButton:
		if event.button_index == MOUSE_BUTTON_RIGHT:
			if event.pressed:
				dragging = true
				last_mouse_position = event.position
			else:
				dragging = false
	elif event is InputEventMouseMotion and dragging:
		var mouse_delta = event.position - last_mouse_position
		position -= mouse_delta
		last_mouse_position = event.position

'''
