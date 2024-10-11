extends StaticBody2D

func _input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == KEY_F \
	and event.is_pressed():
		self.on_click()



func _on_input_event(viewport, event, shape_idx):
	if event is InputEventMouseButton \
	and event.button_index == MOUSE_BUTTON_LEFT \
	and event.is_pressed():
		self.on_click()
