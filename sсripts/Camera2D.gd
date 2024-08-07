extends Camera2D

var screen_edge_threshold = 20
var max_speed = 400

func _process(delta):
	var mouse_pos = get_viewport().get_mouse_position()
	var viewport_size = get_viewport().size
	var move_vector = Vector2()

	if mouse_pos.x < screen_edge_threshold:
		move_vector.x = -lerp(0, max_speed, 1 - mouse_pos.x / screen_edge_threshold)
	elif mouse_pos.x > viewport_size.x - screen_edge_threshold:
		move_vector.x = lerp(0, max_speed, (mouse_pos.x - (viewport_size.x - screen_edge_threshold)) / screen_edge_threshold)

	if mouse_pos.y < screen_edge_threshold:
		move_vector.y = -lerp(0, max_speed, 1 - mouse_pos.y / screen_edge_threshold)
	elif mouse_pos.y > viewport_size.y - screen_edge_threshold:
		move_vector.y = lerp(0, max_speed, (mouse_pos.y - (viewport_size.y - screen_edge_threshold)) / screen_edge_threshold)

	global_position += move_vector * delta



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
